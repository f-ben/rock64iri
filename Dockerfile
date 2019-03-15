FROM arm64v8/maven:3.5-jdk-8 as builder
ARG REPO_ROCKSDB=https://github.com/facebook/rocksdb.git
ARG REPO_ROCKSDB_BRANCH=5.18.fb
ARG ROCKSDB_VERSION=5.18.3
ARG REPO_SNAPPY=https://github.com/google/snappy.git
ARG REPO_IRI=https://github.com/f-ben/iri.git
ARG ARCH_FLAGS="-march=armv8-a+crc+crypto -mtune=cortex-a53"

# Replace OpenJDK with Oracle-8 JDK and autoaccept EULA
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
RUN apt-get remove openjdk* -y \
 && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
 && echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
 && apt-get update && apt-get install -y oracle-java8-installer iputils-ping nano cmake autotools-dev automake build-essential maven --no-install-rec$

# Clone and build RocksDB
WORKDIR /iri-aarch64
RUN git clone $REPO_ROCKSDB -b $REPO_ROCKSDB_BRANCH
WORKDIR /iri-aarch64/rocksdb
RUN set -x \
 && make \
      CC=gcc \
      CXX=g++ \
      AR=ar \
      STRIP=strip \
      EXTRA_CFLAGS="${ARCH_FLAGS} -fuse-ld=gold -I./snappy-1.1.7/build" \
      EXTRA_CXXFLAGS="${ARCH_FLAGS} -static-libstdc++ -fuse-ld=gold -I./snappy-1.1.7/build" \
      EXTRA_LDFLAGS="-Wl,-Bsymbolic-functions -Wl,--icf=all" \
      EXTRA_AMFLAGS="--host=aarch64-linux-gnu" \
      DEBUG_LEVEL=0 \
      rocksdbjavastatic \
 && rm /usr/share/maven/boot/plexus-classworlds-2.5.2.jar
ENV M2_HOME=/usr/share/maven
ENV M2=/usr/share/maven/bin
WORKDIR /iri-aarch64/rocksdb/java/target/
RUN mvn install:install-file -Dfile=rocksdbjni-${ROCKSDB_VERSION}-linux64.jar -DgroupId=org.rocksdb -DartifactId=rocksdbjni -Dversion=${ROCKSDB_VERSI$

# Clone and build IRI
WORKDIR /iri-aarch64
RUN git clone $REPO_IRI
WORKDIR /iri-aarch64/iri
RUN mvn clean compile && mvn package

# Run IRI
FROM openjdk:jre-slim
COPY --from=builder /iri-aarch64/iri/target/iri-*.jar /iri/iri.jar
VOLUME /iri
VOLUME /data
EXPOSE 14600/udp
EXPOSE 15600
EXPOSE 14265
ENTRYPOINT java -XX:+CrashOnOutOfMemoryError -Xmx3G -Xms1G -jar /iri/iri.jar -c /data/iota.ini

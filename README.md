# rock64iota IRI
IOTA IRI dockerfiles for the rock64 SBC

The following steps require your rock64 to have the latest aryufan-docker-release installed and an external USB SSD formatted with ext4 filesystem.

1. connect and mount external USB SSD

	1.1 create mount folder
	
		mkdir -p /mnt/usb
	
	1.2 find the UUID of your external drive (look for /dev/sda)
	
		blkid
	
	1.3 add the following line to /etc/fstab
	
		UUID=yourUUIDhere /mnt/usb ext4 defaults,discard 0 2
	
	1.4 mount the drive

		mount -a

2. clone this repository (dont forget the dot at the end when using git clone)

		cd /mnt/usb && git clone https://github.com/f-ben/rock64iota.git && cd ./rock64iota
	
3. find neighbors in iota discord and edit neighbors-line in ./data/iri/iota.ini

		nano ./data/iri/iota.ini

		NEIGHBORS = udp://neighbor1:port tcp://neighbor2:port udp://neighbor3:port tcp://neighbor4:port
	
4. download new database

		chmod +x ./downloaddb.sh && ./downloaddb.sh

5. start docker container

		chmod +x ./startdockercontainer.sh && ./startdockercontainer.sh

Forward the following ports to your rock64:

Port/Type | Use 
--- | ---
14265/tcp | IOTA/IRI API port
14600/udp | IOTA/IRI UDP connection port
15600/tcp | IOTA/IRI TCP connection port

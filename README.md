## rock64iri
Since IRI 1.6.1 got a lot of improvements in memory management I felt it was a good time to get my rock64 out of the shelf again. IRI runs perfectly fine with 2GB of RAM these days so running it got a lot easier (without swap-file, hickups and so on). This repository is supposed to be a short tutorial and handful of usefull scripts to get IRI on your rock64 running in minutes.

### basic setup

The following steps require your rock64 to have the latest ayufan-**containers-release** (https://github.com/ayufan-rock64/linux-build) installed and an external USB SSD formatted with ext4 filesystem.

1. connect and mount external USB SSD

	1.1 add yourself to docker group, update system and restart
	
		sudo adduser ${USER} docker && sudo apt-get update && sudo apt-get upgrade -y && sudo reboot

	1.2 create mount folder
	
		sudo mkdir -p /mnt/usb
	
	1.3 find the UUID of your external drive (look for /dev/sda)
	
		sudo blkid
	
	1.4 add the following line to /etc/fstab (edit with ```sudo nano /etc/fstab```)
	
		UUID=yourUUIDhere /mnt/usb ext4 defaults,discard 0 2
	
	1.5 mount the drive

		sudo mount -a

2. clone this repository and set file permissions

		cd /mnt/usb && git clone https://github.com/f-ben/rock64iri.git && cd ./rock64iri && chmod +x *.sh
	
3. find neighbors in iota discord and edit neighbors-line in iota.ini config file (edit with ```nano ./data/iota.ini```)

		NEIGHBORS = udp://neighbor1:port tcp://neighbor2:port udp://neighbor3:port tcp://neighbor4:port
	
4. download new database and do the initial run of the docker container

		./downloaddb.sh && ./start.sh

5. Forward the following ports from your router to your rock64:

		Port/Type and usage
		14265/tcp | IOTA/IRI API port
		14600/udp | IOTA/IRI UDP neighbor connection port
		15600/tcp | IOTA/IRI TCP neighbor connection port

### Additional Information

use ```docker stop iri``` ```docker start iri``` or ```docker restart iri``` to stop/start/restart the IRI container

```./showlog.sh``` can be used to check the log of IRI (exit with CTRL+C)

```./getnodeinfo.sh``` can be used to check the local node information

If you need assistance feel free to ask in the iota discord ```#help``` channel or write a discord PM to ```Ben.#0981```

### Thanks

Thanks a lot to muxXer and perfectstorm85 for the IRI/Docker/Rock64 work they did before. Made it a lot easier for me and I was able to copy/paste a lot of stuff :)

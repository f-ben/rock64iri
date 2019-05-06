## rock64iri
Since IRI 1.6.1 got a lot of improvements in memory management I felt it was a good time to get my rock64 out of the shelf again. IRI runs perfectly fine with 2GB of RAM these days so running it on the rock64 got a lot easier (without swap-file, hickups and so on). This repository is supposed to be a short tutorial and handful of useful scripts to get IRI running on your rock64 in minutes.

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

		cd /mnt/usb && git clone https://github.com/f-ben/rock64iri.git && cd ./rock64iri && chmod +x *.sh && sudo ./mvdocker.sh
	
3. find neighbors in iota discord and edit neighbors-line in iota.ini config file (edit with ```nano ./data/iota.ini```)

		NEIGHBORS = udp://neighbor1:port tcp://neighbor2:port udp://neighbor3:port tcp://neighbor4:port
	
4. initialize docker container

		./run.sh

5. download snapshotted database

		./downloaddb.sh

6. Forward the following ports from your router to your rock64:

		Port/Type and usage
		14265/tcp | IOTA/IRI API port
		14600/udp | IOTA/IRI UDP neighbor connection port
		15600/tcp | IOTA/IRI TCP neighbor connection port

### additional information
1. **Use** ```./stop.sh``` ```./start.sh``` or ```./restart.sh``` to stop/start/restart the IRI container

2. **Do not use** ```docker stop``` or ```docker restart``` since this can break your IRI database!

3. ```./showlog.sh``` can be used to check the log of IRI (exit with CTRL+C)

4. ```./getnodeinfo.sh``` can be used to check the local node information

5. If you notice lags or high latency on your network connection there might be an issue with the network driver in the ayufan image. This is a bug which can lead to high temperatures on the ethernet-chip and thus cause packetloss on your connection. To prevent this you can throttle the network connection to 100mbit/s which will prevent overheating but not affect the IRI performance. Also I´d suggest to restart your rock regularly to prevent hickups. To do this run

	```sudo crontab -e```

	and add the following lines:

	```0 */12 * * * /sbin/reboot >/dev/null 2>&1```
	
	```@reboot /sbin/ethtool -s eth0 speed 100 duplex full```

	restart your rock and you are good to go. The first line will reboot your rock every 12 hours, the second line will throttle your network connection to 100mbit/s after the restart.

If you need assistance feel free to ask in the iota discord ```#help``` channel or write a discord PM to ```Ben.#0981```

### image
You can find the built image on hub.docker here: https://hub.docker.com/r/fben/rock64iri

If you want to build the image yourself simply use ```docker build -t <yourowntag> .```

### thanks
Thanks a lot to muXxer and perfectstorm85 for the IRI/Docker/Rock64 work they did before. Made it a lot easier for me and I was able to copy/paste a lot of stuff :)

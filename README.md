# bvc_docker
Brocade SDN Controller working in a docker container

Requirements:
* Docker https://docs.docker.com/userguide/
* Brocade SDN Controller tar gz file (SDN-Controller-2.1.0-Software.gz) which can be downloaded from here: http://www.brocade.com/forms/jsp/vyatta-controller/index.jsp

Note: for OSX and Windows I recommend using boot2docker(https://github.com/boot2docker/boot2docker) or Docker Toolbox(https://www.docker.com/toolbox).  If using boot2docker I recommend initializing it as follows to make sure your vm has enough memory for the Brocade Controller: ```boot2docker init -m 6500```

Setup:
* git clone this repository or simply just download the Dockerfile https://github.com/alrooney/bvc_docker/raw/master/Dockerfile
* put the Dockerfile and the bsc gz file downloaded from the link above into a working directory on your system
* cd to that directory and make sure your docker environment is initialized and type: 
  ```docker build -t bsc .``` NOTE!! don't forget the ```.``` which is how you specify the directory where the Dockerfile exists.  
  This will build the image using the Dockerfile and bsc gz file in your current directory.  The first time you build this image it will take a while (minutes) depending on the speed of your internet connection.
* type: ```docker images``` to see the list of images which should include the image you just built
* to run the image in the foreground (I recommend this until you are sure it is working correctly) type: ```docker run -p 9001:9001 -p 8181:8181 -p 6633:6633 -ti bsc```
* you will see output from the bsc install script and then you will see the bsc log being tailed.  If everything starts correctly you should see the following log message at the end of the startup process: ```2015-10-19 17:09:58,915 | INFO  | sing-executor-11 | NetconfDevice                    | 224 - org.opendaylight.controller.sal-netconf-connector - 1.2.1.Lithium-SR1 | RemoteDevice{controller-config}: Netconf connector initialized successfully```
* with the bsc container running in the foreground like this you can exit it by typing ctrl-c.  Note that if you exit the container using ctrl-c it will terminate the bsc process.  See below for how to run the container in the background.
* To connect to the bsc container, for example to try the UI, you will need to use the docker host address and the mapped ports.  You can see above that we mapped the ports 8181, 9001, and 6633.  To get the docker host address when using boot2docker type: ```boot2docker ip```
* Let's say your boot2docker ip is: 192.168.59.103, then you would open a browser and enter 192.168.59.103:9001 to use the UI
* If you are using boot2docker and you would like to access your bsc container outside your host then you will need to map the ports in virtual box.  To do this on OSX go to settings for the boot2docker-vm in VirtualBox.  Go to Network.  Click on the "Port Forwarding" button.  Then add the port mappings above to the boot2docker-vm.  This will allow you to access the UI by entering localhost:9001 or the IP address of your host machine in the browser or to access the UI from other machines using the IP address of your host machine or connect OF switches to your bsc container using the IP address of your host machine.
* To run your image in the background run it as follows: ```docker run -p 9001:9001 -p 8181:8181 -p 6633:6633 -h bvc-docker-1 -d bsc_image``` and then use: ```docker logs <container_name>``` to see the logs.
* To see your running container type: ```docker ps```
* To stop a container that is running in the background type: ```docker kill <container_name>``` 
* See docker documentation for all the info https://docs.docker.com/userguide/

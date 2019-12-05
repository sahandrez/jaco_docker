# Kinova Jaco 2 Arm Docker
Dockerfile for running Kinova Jaco 2 without any ROS installed on the machine. 
Tested on Ubuntu 18.04.

## Instructions 
* Install Docker from [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/), and follow the instructions [here](https://docs.docker.com/install/linux/linux-postinstall/) to run `docker` without `sudo` access. 

* Pull the `ros:melodic` container from Docker
```
docker pull ros:melodic
```

* Clone this repo into `~/workspace` and build the docker image:
```
mkdir ~/workspace && cd ~/workspace
git clone https://github.com/sahandrez/jaco_docker.git
docker build --tag jaco_control .
```

* Connect the robot with via the USB connection.

* Run the Docker container with access to the USB devices for establishing connection to the robot: 
```
docker run -it --name jaco_robot --privileged -v /dev/bus/usb:/dev/bus/usb  jaco_control
```

* You can connect to the running container using the following command:
```
docker exec -it jaco_robot /bin/bash
```

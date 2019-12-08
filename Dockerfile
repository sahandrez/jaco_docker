# Docker file for a ROS Melodic environment with kinova-ros package for running Kinova Jaco 2 Arm

FROM ros:melodic

RUN apt-get update && \
    apt-get install -y python python-tk git python-pip vim build-essential 
RUN apt-get install -y ros-melodic-moveit ros-melodic-tf-conversions ros-melodic-trac-ik \ 
    ros-melodic-eigen-conversions ros-melodic-ros-control ros-melodic-ros-controllers \
    ros-melodic-robot-state-publisher libblas-dev liblapack-dev

RUN pip install numpy

# Source ROS setup.bash
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash" 

# Make and initialize the catkin_ws
RUN mkdir -p ~/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws; catkin_make'
RUN /bin/bash -c "source ~/catkin_ws/devel/setup.bash"

# Clone and make the kinova-ros package
RUN cd ~/catkin_ws/src/ && \
    git clone https://github.com/Kinovarobotics/kinova-ros.git && \
    /bin/bash -c '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws; catkin_make'

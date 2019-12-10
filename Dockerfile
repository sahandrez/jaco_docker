# Docker file for a ROS Melodic environment with kinova-ros package for running Kinova Jaco 2 Arm

FROM ros:melodic

RUN apt-get update && apt-get install -y \
    python \
    python-tk \
    git \
    python-pip \
    vim \
    build-essential \
    unzip \
    wget \
    libglfw3 \
    libglew2.0 \
    libgl1-mesa-glx \
    libosmesa6 \
    libblas-dev \
    liblapack-dev

RUN apt-get install -y \
    ros-melodic-moveit \
    ros-melodic-tf-conversions \
    ros-melodic-trac-ik \
    ros-melodic-eigen-conversions \
    ros-melodic-ros-control \
    ros-melodic-ros-controllers \
    ros-melodic-robot-state-publisher

RUN pip install numpy

# Source ROS setup.bash
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash" 

# Make and initialize the catkin_ws
RUN mkdir -p ~/catkin_ws/src
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws; catkin_make'
RUN /bin/bash -c "source ~/catkin_ws/devel/setup.bash"

# Clone and make the kinova-ros package
RUN cd ~/catkin_ws/src/ \
    && git clone https://github.com/Kinovarobotics/kinova-ros.git \
    && /bin/bash -c '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws; catkin_make'

# Install Mujoco
RUN mkdir -p ~/.mujoco \
    && wget https://www.roboti.us/download/mujoco200_linux.zip -O mujoco200_linux.zip \
    && unzip mujoco200_linux.zip -d ~/.mujoco \
    && rm mujoco200_linux.zip
COPY ./mjkey.txt /root/.mujoco/
COPY ./mjkey.txt /root/.mujoco/mujoco200_linux/bin/

# Clone and install Deepmind Control Suite
RUN mkdir -p ~/workspace \
    && cd ~/workspace \
    && git clone https://github.com/sahandrez/dm_control.git --branch jaco_arm \
    && pip install dm_control/

# Clone and make the robot_learning package


RUN pip install scipy

WORKDIR /root/catkin_ws/src

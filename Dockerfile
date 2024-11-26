ARG ROS_DISTRO=humble

FROM ros:${ROS_DISTRO}-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-joy-linux \
    && rm -rf /var/lib/apt/lists/*

COPY ros_entrypoint.sh .

ENV LAUNCH_COMMAND='ros2 run joy_linux joy_linux_node'

RUN echo 'alias run="su - ros --whitelist-environment=\"ROS_DOMAIN_ID\" /run.sh"' >> /etc/bash.bashrc && \
    echo "source /opt/ros/$ROS_DISTRO/setup.bash; echo UID: $UID; echo ROS_DOMAIN_ID: $ROS_DOMAIN_ID; $LAUNCH_COMMAND" >> /run.sh && chmod +x /run.sh

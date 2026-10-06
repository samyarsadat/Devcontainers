#!/usr/bin/env bash
set -Eeuo pipefail

# shellcheck source=/dev/null
. /usr/local/lib/dev-environments/feature-lib.sh
# shellcheck source=/dev/null
. "$FEATURE_LIB/ros-lib.sh"

apt_install libasio-dev libtinyxml2-dev
build_ros_overlay https://github.com/micro-ROS/micro-ROS-Agent.git /opt/microros/agent

apt_cleanup

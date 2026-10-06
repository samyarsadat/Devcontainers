#!/usr/bin/env bash
set -Eeuo pipefail

# shellcheck source=/dev/null
. /usr/local/lib/dev-environments/feature-lib.sh
# shellcheck source=/dev/null
. "$FEATURE_LIB/ros-lib.sh"

apt_install libcurl4-openssl-dev flex bison libncurses-dev

build_ros_overlay https://github.com/micro-ROS/micro_ros_setup.git /opt/microros/setup
install -m 0755 "$(dirname "$0")/scripts/devenv-microros-build" "$FEATURE_BIN/devenv-microros-build"

apt_cleanup

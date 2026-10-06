# shellcheck shell=bash

# shellcheck source=/dev/null
. /usr/local/lib/dev-environments/feature-lib.sh

# shellcheck source=/dev/null
. "/opt/ros/$ROS_DISTRO/setup.bash"

while IFS= read -r devenv_ros_setup; do
    # shellcheck disable=SC1090
    . "$devenv_ros_setup"
done <"$FEATURE_SHARE/ros-overlays"
unset devenv_ros_setup

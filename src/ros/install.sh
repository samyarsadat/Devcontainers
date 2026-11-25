#!/usr/bin/env bash
set -Eeuo pipefail

# shellcheck source=/dev/null
. /usr/local/lib/dev-environments/feature-lib.sh

apt_install python3-rosdep python3-colcon-common-extensions python3-vcstool \
    build-essential cmake ninja-build gdb clang clang-format clang-tidy python3-colcon-mixin \
    python3-pytest pipx "ros-$ROS_DISTRO-ament-lint-auto" "ros-$ROS_DISTRO-ament-lint-common"

if ! test -f /etc/ros/rosdep/sources.list.d/20-default.list; then
    rosdep init
fi

run_as_nonroot rosdep update

touch "$FEATURE_SHARE/ros-overlays"
chmod 0644 "$FEATURE_SHARE/ros-overlays"

install -m 0644 "$(dirname "$0")/scripts/ros-setup.sh" "$FEATURE_LIB/ros-setup.sh"
install -m 0644 "$(dirname "$0")/scripts/ros-lib.sh" "$FEATURE_LIB/ros-lib.sh"

run_as_nonroot colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
run_as_nonroot colcon mixin update default

bash_init=". $FEATURE_LIB/ros-setup.sh"
grep -qxF "$bash_init" /etc/bash.bashrc || printf "\n%s\n" "$bash_init" >> /etc/bash.bashrc

apt_cleanup

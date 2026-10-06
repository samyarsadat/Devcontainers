#!/usr/bin/env bash

build_ros_overlay() (
    set -Eeuo pipefail

    repository="$1"
    install_root="$2"
    pkg_setup="$install_root/install/local_setup.bash"

    set +u
    # shellcheck source=/dev/null
    . "/opt/ros/$ROS_DISTRO/setup.bash"
    set -u

    if ! test -r "$pkg_setup"; then
        tmp_dir="$(mktemp -d /tmp/devenv-ros-overlay.XXXXXX)"
        trap 'rm -rf "$tmp_dir"' EXIT
        cd "$tmp_dir"

        git clone --branch "$ROS_DISTRO" --depth 1 "$repository" src/package
        rosdep install --from-paths src --ignore-src -r -y

        rm -rf "$install_root/install"
        install -d -m 0755 "$install_root"

        colcon build --merge-install \
            --install-base "$install_root/install" \
            --cmake-args -DBUILD_TESTING=OFF
    fi

    overlay_registry="$FEATURE_SHARE/ros-overlays"
    grep -qxF "$pkg_setup" "$overlay_registry" || printf "%s\n" "$pkg_setup" >> "$overlay_registry"
)

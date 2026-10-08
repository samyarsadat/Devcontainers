#!/usr/bin/env bash
set -Eeuo pipefail

# shellcheck source=/dev/null
. "$(dirname "$0")/scripts/feature-lib.sh"

packages=(ca-certificates curl git jq rsync unzip xz-utils bash-completion shellcheck)
if test "$GUI" = "true"; then
    packages+=(libgl1 libegl1 libgl1-mesa-dri libxkbcommon-x11-0 mesa-utils qtwayland5 wayland-utils)
fi
apt_install "${packages[@]}"

install -d -m 0755 "$FEATURE_LIB" "$FEATURE_SHARE" "$FEATURE_BIN"
install -m 0644 "$(dirname "$0")/scripts/feature-lib.sh" "$FEATURE_LIB/feature-lib.sh"

apt_cleanup

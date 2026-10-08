#!/usr/bin/env bash
set -Eeuo pipefail

# shellcheck source=/dev/null
. /usr/local/lib/dev-environments/feature-lib.sh

# shellcheck source=/dev/null
. "$(dirname "$0")/versions.env"

tmp_dir="$(mktemp -d /tmp/devenv-pico.XXXXXX)"
trap 'rm -rf "$tmp_dir"' EXIT

apt_install build-essential cmake ninja-build python3-venv python3-pyelftools \
    gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
    pkg-config automake autoconf libtool texinfo libusb-1.0-0-dev \
    libhidapi-dev libjim-dev gdb-multiarch usbutils udev picocom

usermod -aG dialout,plugdev "$USERNAME"

sdk_root=/opt/pico/sdk
rm -rf "$sdk_root"
install -d -m 0755 /opt/pico

git clone --branch "$PICO_SDK_VERSION" --depth 1 https://github.com/raspberrypi/pico-sdk.git "$sdk_root"
git -C "$sdk_root" submodule update --init --recursive --depth 1

(
    install -d -m 0755 "$tmp_dir/picotool"
    cd "$tmp_dir/picotool"

    git clone --branch "$PICO_SDK_VERSION" --depth 1 https://github.com/raspberrypi/picotool.git .
    git submodule update --init --recursive --depth 1

    cmake -B build -G Ninja -DPICO_SDK_PATH="$sdk_root"
    cmake --build build --parallel
    cmake --install build
)

(
    install -d -m 0755 "$tmp_dir/openocd"
    cd "$tmp_dir/openocd"

    git clone --filter=blob:none --no-checkout https://github.com/raspberrypi/openocd.git .
    git checkout --detach "$OPENOCD_COMMIT"
    git submodule update --init --recursive --depth 1

    ./bootstrap
    ./configure --disable-werror --enable-cmsis-dap --disable-ftdi
    make -j"$(nproc)"
    make install
)

venv="$FEATURE_LIB/pico/venv"
python3 -m venv --clear "$venv"
"$venv/bin/python" -m pip install --disable-pip-version-check elf-size-analyze
ln -sfn "$venv/bin/elf-size-analyze" "$FEATURE_BIN/elf-size-analyze"

install -D -m 0644 "$(dirname "$0")/assets/openocd/pico.cfg" "$FEATURE_SHARE/pico/openocd/pico.cfg"

apt_cleanup

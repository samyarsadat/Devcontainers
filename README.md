<h1 align="center">Devcontainers</h1>

<p align="center">
	<a href="LICENSE"><img src="https://img.shields.io/github/license/samyarsadat/Devcontainers?color=blue"></a>
	|
	<a href="../../issues"><img src="https://img.shields.io/github/issues/samyarsadat/Devcontainers"></a>
	<br><br>
</p>

<br>

----
This repository contains feature sources and image profiles for all of my custom Development Containers.

### CI Status

[![Build & Push Images](https://github.com/samyarsadat/Devcontainers/actions/workflows/images.yml/badge.svg)](https://github.com/samyarsadat/Devcontainers/actions/workflows/images.yml) \
[![Validate & Publish Features](https://github.com/samyarsadat/Devcontainers/actions/workflows/features.yml/badge.svg)](https://github.com/samyarsadat/Devcontainers/actions/workflows/features.yml)

> [!NOTE]
> Profile images are automatically updated every Tuesday.

<br>

### Repository Structure

Re-usable Devcontainer features and their associated files are under [`./src`](./src/).\
Profile image definitions are under [`./profiles`](./profiles/).

> [!NOTE]
> When using a CMSIS-DAP probe with the Pico, be sure to set the `PICO_CHIP` environment variable
> to either `2040` or `2350` for `RP2040` and `RP2350` targets, respectively.

<br>

### List of Features

| Name                                                           | Description                                                     |
| -------------------------------------------------------------- | --------------------------------------------------------------- |
| [foundation](src/foundation/devcontainer-feature.json)         | Common development tools and optional Wayland GUI support.      |
| [pico](src/pico/devcontainer-feature.json)                     | Pico SDK, Picotool, ELF inspection, OpenOCD, and VSCode config. |
| [ros](src/ros/devcontainer-feature.json)                       | ROS 2 development tooling for C++ and Python.                   |
| [microros-build](src/microros-build/devcontainer-feature.json) | Micro-ROS library build (micro_ros_setup) feature overlay.      |
| [microros-agent](src/microros-agent/devcontainer-feature.json) | Micro-ROS agent feature overlay.                                |

### List of Profile Images

| Name                                                                  | Description                          |
| --------------------------------------------------------------------- | ------------------------------------ |
| [pico-sdk](profiles/pico-sdk/devcontainer.json)                       | Pico SDK Profile (Ubuntu 26.04)      |
| [pico-microros-jazzy](profiles/pico-microros-jazzy/devcontainer.json) | Pico SDK + micro-ROS (Jazzy) Profile |
| [ros-desktop-jazzy](profiles/ros-desktop-jazzy/devcontainer.json)     | ROS 2 (Jazzy) Full Desktop Profile   |

<br>

## Contact

You can contact me via e-mail.\
E-mail: samyarsadat@gigawhat.net

If you think that you have found a bug or issue please report it [here](../../issues).

<br>

----
Copyright © 2026 Samyar Sadat Akhavi.

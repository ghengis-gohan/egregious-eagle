# Edge Flight Simulator: Day 2 Operations Demo

This project demonstrates the power of atomic, image-based updates at the edge using **Red Hat Enterprise Linux (RHEL) Image Mode (`bootc`)** and **Red Hat Edge Manager (RHEM)**. 

By deploying a fully containerized operating system to NVIDIA Jetson Orin Nanos, this demo highlights how hardware can remain constant while the entire OS and application payload is fluidly swapped based on the mission or use-case.

## 🚀 Project Overview

The core application is the **FlightGear** flight simulator running in a headless Wayland environment via **Cage** and broadcasted over VNC. 

During the demo, the Jetsons are centrally managed via RHEM. The presenter initiates an image swap (e.g., from a V-22 Osprey to an F-35B). The `flightctl-agent` pulls the new OS container in the background, stages it, and reboots the device into the new aircraft simulator—proving that edge device lifecycles can be managed exactly like cloud-native containers.

The core application is the **FlightGear** flight simulator running in a headless Wayland environment via **Cage** and broadcasted over VNC. 

During the demo, the Jetsons are centrally managed via RHEM. The presenter initiates an image swap (e.g., from a V-22 Osprey to an F-35B). The `flightctl-agent` pulls the new OS container in the background, stages it, and reboots the device into the new aircraft simulator—proving that edge device lifecycles can be managed exactly like cloud-native containers.

## 🏗️ Architecture

* **Hardware:** NVIDIA Jetson Orin Nano (ARM64 / aarch64)
* **Base OS:** RHEL 9.4 Image Mode (`registry.redhat.io/rhel9/rhel-bootc:9.4`)
* **Edge Workload / Management:** Microshift, `flightctl-agent`
* **Application:** FlightGear (`fgfs`)
* **Display Server:** Cage (Wayland Kiosk Compositor)
* **Streaming:** WayVNC (Headless network broadcast)
* **Hardware Acceleration:** NVIDIA Container Toolkit & JetPack passthrough

## 📁 Repository Structure

To maintain clean build contexts, each vehicle variant has its own isolated directory containing its specific `Containerfile`, runtime scripts, and systemd service configurations.

```text
jetson-edge-demo/
├── README.md
├── V22/
│   ├── Containerfile
│   ├── flightgear.service                  # Configured with --aircraft=V22-Osprey
│   ├── start-simulator.sh                  # WayVNC and Cage execution wrapper
│   ├── nvidia-cdi.service                  # Generates CDI mappings for Jetson iGPU
│   ├── microshift-make-rshared.service     # Prepares filesystem for OVN images
│   ├── microshift-copy-images              # Workaround script for image upgrades
│   └── microshift-copy-images.conf         # Drop-in unit for MicroShift
├── F35B/
│   ├── Containerfile
│   ├── flightgear.service                  # Configured with --aircraft=F-35B
│   ├── start-simulator.sh
│   ├── nvidia-cdi.service
│   ├── microshift-make-rshared.service
│   ├── microshift-copy-images
│   └── microshift-copy-images.conf
└── A10/
    ├── Containerfile
    ├── flightgear.service                  # Configured with --aircraft=A-10
    ├── start-simulator.sh
    ├── nvidia-cdi.service
    ├── microshift-make-rshared.service
    ├── microshift-copy-images
    └── microshift-copy-images.conf
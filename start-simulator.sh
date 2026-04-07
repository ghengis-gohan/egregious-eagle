#!/bin/bash

# 1. Start Weston on the RHEL Host (Headless Kiosk + VNC on port 5900) in the background
weston --backend=vnc-backend.so --shell=kiosk-shell.so &

# Give Weston 3 seconds to establish the Wayland display socket
sleep 3

# 2. Launch the FlightGear App Container
# - Passes the Jetson's GPU (--device=/dev/dri)
# - Passes the Weston display socket (-v and -e)
# - Pulls the pre-built V-22 app image
podman run --rm --net=host \
  --device=/dev/dri \
  -v /run/user/$(id -u)/wayland-1:/tmp/wayland-1 \
  -e WAYLAND_DISPLAY=/tmp/wayland-1 \
  quay.io/rh-ee-soanders/egregious-eagle:v22
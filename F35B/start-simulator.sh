#!/bin/bash

# Start the Wayland VNC server in the background, listening on all IP addresses, port 5900
wayvnc 0.0.0.0 5900 &

# Start FlightGear in the foreground, passing along any arguments from systemd
exec /usr/bin/fgfs "$@"
#!/bin/bash

# This script does not make any changes to the original package; it only
# extracts and unpacks the data into the system as it was originally built. 
# Subsequent routines only remove the data extracted by it, as originally 
# programmed, without any modifications to the original software.

# receive arguments
arg1="$1"
arg2="$2"

# Function install Iriun Webcam.
install_irun() {
# Access tmp directory
cd $(mktemp -d)

# Download and install Iriun Webcam and extract its contents to the root.
if wget -q https://iriun.gitlab.io/iriunwebcam-2.9.deb; then
    ar -x iriunwebcam-2.9.deb
    tar -xf data.tar.zst -C /
    echo "Iriun Webcam installed successfully."
else
    echo "Failed to download Iriun Webcam package."
    echo "Execution sudo iriunwebcam-install -i."
    exit 2
fi
}

# Function Remove iriunwebcam if already installed
remove_iriun() { 
if rm -fv /etc/modprobe.d/iriunwebcam-options.conf     \
    /etc/modules-load.d/iriunwebcam.conf               \
    /usr/local/bin/iriunwebcam                         \
    /usr/share/applications/iriunwebcam.desktop        \
    /usr/share/pixmaps/iriunwebcam.png; then
    echo "Removed previous Iriun Webcam installation."
else
    echo "No previous Iriun Webcam installation found."
    exit 3
fi
}

# Function help for the script 
help() {
cat << 'EOF'

Usage: iriunwebcam-install [OPTIONS]

--version, -v - Show the script version
--help,    -h - Show this help menu
--install, -i - Install Iriun Webcam on Fedora Linux
--remove,  -r - Remove Iriun Webcam from Fedora Linux

Example:
sudo iriunwebcam-install -i (install the software)
sudo iriunwebcam-install -r (remove  the software)

EOF
return 1
}

# Some checks before executing routines
case "$arg1" in
  --version|-v)
      echo "iriunwebcam-install version - 0.0.1"
      ;;
  --help|-h)
      help
      ;;
  --install|-i)
  	  install_iriun
      ;;
  --remove|-r)
      remove_iriun
  	  ;;
  *)
      help
      ;;
esac

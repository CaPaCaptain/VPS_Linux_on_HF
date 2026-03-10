---
title: VPS Linux
emoji: 🐨
colorFrom: red
colorTo: green
sdk: docker
pinned: false
license: mit
---

Check out the configuration reference at https://huggingface.co/docs/hub/spaces-config-reference

# Simplified Linux VPS on Hugging Face Spaces
This is a configuration template for running a simplified Linux VPS on Hugging Face Spaces. It is based on the lightweight Debian Bookworm Slim, pre-installed with basic development tools and the ttyd web terminal, allowing you to access the command line directly in your browser.
This environment is configured with sudo privileges, making it convenient to install required software (such as OpenClaw) at runtime.
🚀 Quick Start
1. Create a Hugging Face Space
Log in to Hugging Face.
Click your avatar in the top right corner -> New Space.
Enter a Space name (e.g., my-linux-vps).
Select the Space SDK: Choose Docker.
Docker Template: Choose Blank.
Click Create Space.
2. Upload Files
Upload the Dockerfile and README.md from this repository to your Space repository.
3. Access the VPS
Wait for the Space to finish building (the Build status will change to Running).
Click the App tab at the top of the Space page, and you will see a web terminal.
🛠️ Features
Base System: Debian Bookworm Slim (lightweight and highly compatible).
Root Privileges: The default user user has passwordless sudo access.
Development Tools: Pre-installed with git, curl, wget, vim, nano, build-essential, and cmake.
Web Terminal: Uses ttyd to provide a smooth browser-based terminal experience.
🎮 How to Run OpenClaw
OpenClaw is a graphical game that requires relevant dependencies to be installed on the VPS for compilation or execution. Since Hugging Face Spaces does not have a graphical interface (Display) by default, you can usually only compile it or run it in server mode (if supported). To run the graphical interface, you need to configure VNC or X11 forwarding on your own (which is quite complex and may be limited by the network).
Install OpenClaw Dependencies
Run the following commands in the terminal to install the libraries required to compile OpenClaw:
bash
运行
# Update software sources
sudo apt-get update

# Install SDL2 and related dependencies (core requirements for OpenClaw)
sudo apt-get install -y \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libxml2-dev \
    zlib1g-dev
Obtain and Compile OpenClaw
bash
运行
# Clone the OpenClaw repository
git clone https://github.com/pjasicek/OpenClaw.git
cd OpenClaw

# Create a build directory
mkdir build && cd build

# Compile
cmake ..
make -j$(nproc)
Notes
Graphical Interface Limitation: Running ./OpenClaw directly may throw an error Could not initialize SDL: No available video device, as the Space is not connected to a display.
Persistent Storage: After a Hugging Face Space restarts, files not in the /data directory will be lost. It is recommended to save important data in the /data directory (if Persistent Storage is enabled) or sync code using Git.
⚠️ Security Warning
This VPS has root privileges. Do not store sensitive keys in it.
Hugging Face Spaces are public (unless set to Private). It is recommended to set your Space to Private in the Space settings to prevent others from accessing your terminal.

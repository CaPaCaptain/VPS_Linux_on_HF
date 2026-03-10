# Use a lightweight Debian base for a simplified Linux environment
FROM debian:bookworm-slim

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/user
ENV PATH=$HOME/.local/bin:$PATH

# Install essential system packages and build tools
# - sudo: Required for root privileges
# - build-essential, cmake: Required for compiling software like OpenClaw
# - curl, wget, git: Basic tools for downloading and version control
# - vim, nano: Text editors
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    vim \
    nano \
    unzip \
    procps \
    net-tools \
    build-essential \
    cmake \
    pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install ttyd (Web Terminal) to access the VPS via browser
# Using a specific version to ensure stability
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 -O /usr/bin/ttyd \
    && chmod +x /usr/bin/ttyd

# Create a non-root user 'user' (UID 1000) for security and Hugging Face compatibility
# Grant sudo privileges without password for easy administration
RUN useradd -m -u 1000 user && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set working directory to user's home
WORKDIR $HOME

# Switch to the non-root user
USER user

# Expose port 7860 (Standard for Hugging Face Spaces)
EXPOSE 7860

# Start ttyd on port 7860 with writable access
CMD ["ttyd", "-p", "7860", "-W", "bash"]

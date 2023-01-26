FROM ubuntu:20.04

# Update the package manager and install necessary packages
RUN apt-get update && apt-get install -y \
    chromium-browser \
    x11vnc \
    xvfb \
    libgconf2-4 \
    libnss3-dev \
    libgtk-3-dev \
    libxss1 \
    libasound2 \
    pulseaudio \
    --no-install-recommends

# Create a non-root user to run the browser
RUN useradd -m chrome
USER chrome

# Set the working directory
WORKDIR /home/chrome

# Set the default URL to open
ENV URL https://www.google.com

# Start the Xvfb and VNC servers
CMD Xvfb :99 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \
    x11vnc -forever -usepw -create -display :99 & \
    DISPLAY=:99 chromium-browser --no-sandbox --disable-dev-shm-usage --disable-setuid-sandbox --remote-debugging-address=0.0.0.0 ${URL}

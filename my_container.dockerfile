FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -yq libgconf-2-4 wget unzip xvfb

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# Create non-root user
RUN useradd -m chrome
USER chrome

# Expose port 80
EXPOSE 80

# Start xvfb (X virtual framebuffer)
ENV DISPLAY :99
RUN Xvfb :99 -ac -screen 0 1280x1024x24 &

# Run Chrome in headless mode and specify the port
ENTRYPOINT xvfb-run --auto-servernum --server-args='-screen 0, 1280x1024x24' google-chrome-stable --remote-debugging-port=80

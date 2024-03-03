# docker-camera-streamer

Dockerfile for ayufan/camera-streamer to stream WebRTC to Octoprint.


## Compose Example
```docker-compose
services:
  camera-streamer:
      image: camera-streamer:latest
      container_name: camera-streamer
      restart: unless-stopped
      # TODO Figure out ports to avoid host network
      # ports:
      #   - 8080:8080
      #   - 8080:8080/udp
      #   - 8554:8554/tcp
      #   - 8554:8554/udp
      network_mode: host
      privileged: true
      volumes:
        - /run/udev:/run/udev:ro
```
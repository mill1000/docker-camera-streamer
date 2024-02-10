FROM debian:bookworm-slim
COPY raspi.list /etc/apt/sources.list.d/raspi.list
COPY raspberrypi-archive-stable.gpg /etc/apt/trusted.gpg.d/raspberrypi-archive-stable.gpg
ARG STREAMER="camera-streamer-raspi_0.2.8.bookworm_arm64.deb"
COPY $STREAMER .
RUN apt-get update && apt install -y tini ./${STREAMER}
ENV CAMERA_FORMAT=YUYV
ENV CAMERA_WIDTH=3280
ENV CAMERA_HEIGHT=2464
ENV SNAPSHOT_HEIGHT=2464
ENV VIDEO_HEIGHT=720
ENV STREAM_HEIGHT=480
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/sh", "-c", "/usr/bin/camera-streamer --camera-path=/base/soc/i2c0mux/i2c@1/imx219@10 --camera-type=libcamera --camera-format=$CAMERA_FORMAT --camera-width=$CAMERA_WIDTH --camera-height=$CAMERA_HEIGHT --camera-fps=30 --camera-nbufs=2 --camera-snapshot.height=$SNAPSHOT_HEIGHT --camera-video.height=$VIDEO_HEIGHT --camera-stream.height=$STREAM_HEIGHT --camera-options=brightness=0.1 --http-listen=0.0.0.0 --http-port=8080 --rtsp-port"]
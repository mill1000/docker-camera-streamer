FROM debian:bookworm-slim
COPY raspi.list /etc/apt/sources.list.d/raspi.list
COPY raspberrypi-archive-stable.gpg /etc/apt/trusted.gpg.d/raspberrypi-archive-stable.gpg
ARG STREAMER="camera-streamer-raspi_0.2.8.bookworm_arm64.deb"
COPY $STREAMER .
RUN apt-get update && apt install -y tini ./${STREAMER}
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/sh", "-c", "/usr/bin/camera-streamer --camera-path=/base/soc/i2c0mux/i2c@1/imx219@10 --camera-type=libcamera --camera-format=YUV420 --camera-width=3280 -camera-height=2464 --camera-fps=30 --camera-nbufs=2 --camera-snapshot.height=1080 --camera-video.height=720 --camera-stream.height=480 --camera-options=brightness=0.1 --http-listen=0.0.0.0 --http-port=8080 --rtsp-port"]
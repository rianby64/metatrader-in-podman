
podman build -f metatrader.Dockerfile -t metatrader .

podman run \
    --rm \
    --ipc=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/rianby64/Test/mt4docker/home:/home/rianby64 \
	-e DISPLAY \
    --ipc=host \
    --userns keep-id \
    --security-opt seccomp=unconfined \
    -u ${USER} \
	metatrader

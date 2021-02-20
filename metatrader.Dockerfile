
FROM ubuntu:groovy

ADD https://dl.winehq.org/wine-builds/winehq.key /Release.key

# Install Wine
RUN apt-get update && \
	apt-get install -y gnupg apt-utils && \
	echo "deb http://dl.winehq.org/wine-builds/ubuntu/ groovy main" >> /etc/apt/sources.list && \
	apt-key add Release.key && \
	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -y --install-recommends winehq-devel firefox \
	&& rm -rf /var/lib/apt/lists/* /Release.key

# Run MetaTrader as non privileged user.
RUN useradd rianby64

RUN mkdir -p /home/rianby64/.wine && chown -R rianby64:rianby64 /home/rianby64/.wine

USER rianby64

# Autorun MetaTrader Terminal.
ENTRYPOINT [ "wine" ]

# CMD [ "/home/rianby64/mt5setup.exe" ]
# CMD [ "/home/rianby64/.wine/drive_c/Program Files/MetaTrader/terminal64.exe" ]
CMD [ "/home/rianby64/.wine/drive_c/Program Files/MetaTrader 5/terminal64.exe" ]

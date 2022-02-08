FROM debian:buster

WORKDIR /build/

# Install deps for Nitrox build
RUN set -x \
    && dpkg --add-architecture i386 \
    && apt update \
    && apt -y --no-install-recommends install apt-transport-https dirmngr gnupg ca-certificates \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update \
    && apt-get -y --no-install-recommends install git wget mono-devel nuget libgdiplus libicu-dev \
    # Clean up
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV DOTNETDIR "/dotnet"

RUN set -x \
    && wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh \
    && chmod +x /tmp/dotnet-install.sh \
	&& mkdir -p "${DOTNETDIR}" \
    && /tmp/dotnet-install.sh --install-dir "${DOTNETDIR}" \
    && rm -rf /tmp/*

# Install steam cmd
ENV STEAMDIR "/steam"
ENV STEAMCMDDIR "${STEAMDIR}/cmd"

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		lib32stdc++6 lib32gcc1 wget ca-certificates nano libsdl2-2.0-0:i386 curl locales \
	&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
	&& dpkg-reconfigure --frontend=noninteractive locales \
	# Download SteamCMD
	&& mkdir -p "${STEAMCMDDIR}" \
	&& wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C "${STEAMCMDDIR}" \
	&& "${STEAMCMDDIR}/steamcmd.sh" +quit \
	&& mkdir -p "${STEAMDIR}/.steam/sdk32" \
	&& ln -s "${STEAMCMDDIR}/linux32/steamclient.so" "${STEAMDIR}/.steam/sdk32/steamclient.so" \
	&& ln -s "${STEAMCMDDIR}/linux32/steamcmd" "${STEAMCMDDIR}/linux32/steam" \
	&& ln -s "${STEAMCMDDIR}/steamcmd.sh" "${STEAMCMDDIR}/steam.sh" \
	# Symlink steamclient.so; So misconfigured dedicated servers can find it
	&& ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
	# Clean up
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH="${DOTNETDIR}:${STEAMCMDDIR}:${PATH}"

#!/bin/bash
set -x

./install_subnautica.sh
./nitrox_build.sh

cd "${SERVER_LOCATION}" && mono "${SERVER_LOCATION}/NitroxServer-Subnautica/bin/Debug/NitroxServer-Subnautica.exe"

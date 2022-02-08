#!/bin/bash

## Install game using steamcmd
GUARDCODE="${STEAM_GUARDCODE}"
if [ -z $GUARDCODE ]; then
  echo ""
  echo "### You did not specify a Steam Guardcode"
  echo "### A new one should be send to you shortly"
  echo "### Enter it in the startup-config after this installation is finished and reinstall the Server"
  sleep 10
  timeout 60 steamcmd.sh +login ${STEAM_USERNAME} ${STEAM_PASSWORD} +quit
  exit 1
fi

SUBNAUTICA_APPID=264710
[ ! -d "${SUBNAUTICA_INSTALLATION_PATH}" ] && mkdir -p "${SUBNAUTICA_INSTALLATION_PATH}"
steamcmd.sh +set_steam_guard_code ${STEAM_GUARDCODE} +login ${STEAM_USERNAME} ${STEAM_PASSWORD} +@sSteamCmdForcePlatformType windows +force_install_dir ${SUBNAUTICA_INSTALLATION_PATH} +app_update ${SUBNAUTICA_APPID} validate +quit
status=$?

if [ $status -ne 0 ]; then
  echo ""
  echo "### The Download was not successful"
  echo "### Probably the entered Guardcode was wrong"
  echo "### A new one should be send to you shortly"
  echo "### Enter it in the startup-config after this installation is finished and reinstall the Server"
  sleep 10
  sleep 10
  timeout 30 steamcmd.sh +login ${STEAM_USERNAME} ${STEAM_PASSWORD} +quit
  exit 1
fi

#!/bin/bash
set -x

BUILD_DIRECTORY="/build"
mkdir -p ${BUILD_DIRECTORY}

git clone https://github.com/SubnauticaNitrox/Nitrox.git "${BUILD_DIRECTORY}"
cd "${BUILD_DIRECTORY}" || exit

# Dirty workaround. We don't have any other way to provide the installDir (or i haven't found it)
# https://github.com/SubnauticaNitrox/Nitrox/blob/62e67c6de9/NitroxModel/Discovery/InstallationFinders/GameInCurrentDirectoryFinder.cs
cd "${SUBNAUTICA_DIR}" && dotnet run --project "${BUILD_DIRECTORY}/Nitrox.BuildTool"
cd "${BUILD_DIRECTORY}" || exit
dotnet build

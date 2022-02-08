#!/bin/bash
set -x

BUILD_DIRECTORY="/build"
mkdir -p ${BUILD_DIRECTORY}

git clone https://github.com/SubnauticaNitrox/Nitrox.git "${BUILD_DIRECTORY}"
cd "${BUILD_DIRECTORY}" || exit

# Create path files to Nitrox Install-Dir
# https://github.com/SubnauticaNitrox/Nitrox/blob/1c5c0d3a8edc90cc2fc46bbf9dc7a384ca39099d/NitroxModel/Discovery/InstallationFinders/ConfigFileGameFinder.cs
echo "${SUBNAUTICA_DIR}" > $HOME/path.txt
cat path.txt

cd "${SUBNAUTICA_DIR}" && dotnet run --project "${BUILD_DIRECTORY}/Nitrox.BuildTool"
cd "${BUILD_DIRECTORY}" || exit
dotnet build

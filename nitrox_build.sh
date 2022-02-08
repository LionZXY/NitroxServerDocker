#!/bin/bash
set -x

BUILD_DIRECTORY="/build"
mkdir -p "${BUILD_DIRECTORY}"

git clone https://github.com/LionZXY/Nitrox.git --branch ${NITROX_VERSION} "${BUILD_DIRECTORY}"
cd "${BUILD_DIRECTORY}" || exit

dotnet run --project "${BUILD_DIRECTORY}/Nitrox.BuildTool" && cd "${BUILD_DIRECTORY}"
dotnet build

mkdir -p "${SERVER_LOCATION}"
cp -r ${BUILD_DIRECTORY}/* "${SERVER_LOCATION}"

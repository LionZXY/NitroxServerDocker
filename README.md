# Nitrox Build Server for Linux in Docker
Using this repository you can build and run Subnautica [Nitrox](https://github.com/SubnauticaNitrox/Nitrox) Server on Linux

# How to start
1) Create file `secrets.env` in project folder and replace username and password to your own
```
STEAM_USERNAME=username
STEAM_PASSWORD=password
STEAM_GUARDCODE=guardcode
```
2) Run `docker-compose up` and then check email for guardcode. Put it in `secrets.env` and run `docker-compose up` again
3) That's all! Check that your server is up and all work correctly

# FAQ

> How i can change version of Nitrox?

You can add `NITROX_VERSION` to `secrets.env`. It can be branch in Nitrox repository or release tag. For example:
```
NITROX_VERSION=master
```

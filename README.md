# protonsocks

Dockerized ProtonVPN

![](https://img.shields.io/github/license/LuKks/protonsocks.svg)

## Install
It requires Docker and Docker Compose:
```
sudo curl -sS https://get.docker.com/ | sh
sudo systemctl enable docker
sudo apt install docker-compose
```

## Configuration
1) Get your OpenVPN / IKEv2 credentials:\
https://account.protonvpn.com/account#openvpn

2) Create `.env` file for global setting, username and password:
```
nano .env
```
```
PVPN_USERNAME=MhDEyyypW76rpujJ
PVPN_PASSWORD=Nuh2vpYKLqe0n8V9slq0EbXLfUpo5ysb
```

- If you need different credentials for a container, override `.env` file:\
`docker run`: use `-e PVPN_USERNAME=abc` and `-e PVPN_PASSWORD=abc`.\
`docker-compose`: change the enviroment variables in `docker-compose.yml`.

- To use NetShield DNS, append a suffix to your username:\
Block malware: `+f1`\
Block malware, ads and trackers: `+f2`\
For example: `PVPN_USERNAME=MhDEyyypW76rpujJ+f1`

- Default ProtonVPN server is `CH-UK#1`, it also can be changed.

## Run with Compose
Later you can just run in foreground:
```
docker-compose up
```
Add `-d` to run in background.
Build locally with `build: .` instead of `image: ghcr.io/lukks/protonsocks`.

## Run without Compose
```
docker run -it --cap-add=NET_ADMIN --env-file=.env -p 1090:1080 \
  -e PVPN_SERVER=CH-UK#1 \
  ghcr.io/lukks/protonsocks
```
Add `-d` to run in background.\
Add `--restart=always` to start automatically on system boot.\
Build locally with `$(docker build -q .)` instead of `ghcr.io/lukks/protonsocks`.

## License
Code released under the [MIT License](https://github.com/LuKks/protonsocks/blob/master/LICENSE).

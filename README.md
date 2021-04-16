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
- Get your OpenVPN / IKEv2 credentials:\
https://account.protonvpn.com/account#openvpn

- Create `.env` file for global setting, username and password:
```
nano .env
```
```
PVPN_USERNAME=MhDEyyypW76rpujJSCw63xGTqjk3WlBS
PVPN_PASSWORD=Nuh2vpYKLqe0n8V9slq0EbXLfUpo5ysb
```

- If you need different credentials for a container, override `.env` file:\
`docker run`: use `-e PVPN_USERNAME=abc` and `-e PVPN_PASSWORD=abc`.\
`docker-compose`: change the enviroment variables in `docker-compose.yml`.

- To use NetShield DNS, append a suffix to your username:\
Block malware: `+f1`\
Block malware, ads and trackers: `+f2`\
For example: `MhDEyyypW76rpujJSCw63xGTqjk3WlBS+f2`

- Default ProtonVPN server is `CH-UK#1`, it also can be changed.

## Run with Compose
Later you can just build and run in foreground:
```
docker-compose up --build
```
Add `-d` to run in background.

## Run without Compose
```
docker run -it --cap-add=NET_ADMIN --env-file=.env -p 1090:1080 \
  -e PVPN_SERVER=CH-UK#1 \
  $(docker build -q .)
```
Add `-d` to run in background.\
Add `--restart=always` to start automatically on system boot.\
Add `--name=protonsocks_ch_uk_1` to set a container name.\
Can use `ghcr.io/lukks/protonsocks` instead of `$(docker build ...)`.

### Build and Run
In case you want to build without immediately run:
```
docker build -t protonsocks .

docker run -it --cap-add=NET_ADMIN --env-file=.env -p 1090:1080 \
  -e PVPN_SERVER=CH-UK#1 \
  protonsocks
```

## License
Code released under the [MIT License](https://github.com/LuKks/protonsocks/blob/master/LICENSE).

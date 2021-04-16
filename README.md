# protonsocks

Dockerized ProtonVPN

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

- Edit `auth.txt` file for global setting, username and password:\
```
nano auth.txt
```
```
MhDEyyypW76rpujJSCw63xGTqjk3WlBS
Nuh2vpYKLqe0n8V9slq0EbXLfUpo5ysb
```

- In case you need different or specific credentials for containers:\
Edit the enviroment in `docker-compose.yml` with the credentials.\
Enviroment variables overrides `auth.txt` file.

- To use NetShield DNS, append a suffix to your username:\
Block malware: `+f1`\
Block malware, ads and trackers: `+f2`\
For example: `MhDEyyypW76rpujJSCw63xGTqjk3WlBS+f2`

- Default ProtonVPN server is `CH-MX#1`, it also can be changed.

## Run with Compose
Later you can just build and run in foreground:
```
docker-compose up --build
```
Add `-d` to run in background.

## Run without Compose
```
docker run -it --cap-add=NET_ADMIN -p 1090:1080 \
  -e PROTONVPN_SERVER=CH-MX#1 \
  $(docker build -q .)
```
Add `-d` to run in background.\
Add `--restart=always` to start automatically on system boot.\
Add `--name=protonsocks_ch_mx_1` to set a container name.\
Add `-e PROTONVPN_USERNAME=abc` and `-e PROTONVPN_PASSWORD=abc` to override `auth.txt`.

### Build and Run
In case you want to build without immediately run:
```
docker build -t protonsocks .

docker run -it --cap-add=NET_ADMIN -p 1090:1080 \
  -e PROTONVPN_SERVER=CH-MX#1 \
  protonsocks
```

## License
Code released under the [MIT License](https://github.com/LuKks/protonsocks/blob/master/LICENSE).

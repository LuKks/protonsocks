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
Get your OpenVPN / IKEv2 credentials:\
https://account.protonvpn.com/account#openvpn

Edit the enviroment variables in `docker-compose.yml` file with your credentials.

To use NetShield DNS, append a suffix to your username:\
Block malware: `+f1`\
Block malware, ads and trackers: `+f2`\
For example: `MhDEyyypW76rpujJSCw63xGTqjk3WlBS+f2`

Default ProtonVPN server is `CH-MX#1`, it also can be changed.

## Run with Compose
Later you can just build and run in foreground:
```
docker-compose up --build
```
Add `-d` to run in background.

## Run without Compose
```
docker run --rm -it --privileged -p 1090:1080 \
  -e PROTONVPN_USERNAME=MhDEyyypW76rpujJSCw63xGTqjk3WlBS \
  -e PROTONVPN_PASSWORD=Nuh2vpYKLqe0n8V9slq0EbXLfUpo5ysb \
  -e PROTONVPN_SERVER=CH-MX#1 \
  $(docker build -q .)
```

### Build and Run
In case you want to build without immediately run:
```
docker build -t protonsocks .

docker run --rm -it --privileged -p 1090:1080 \
  -e PROTONVPN_USERNAME=MhDEyyypW76rpujJSCw63xGTqjk3WlBS \
  -e PROTONVPN_PASSWORD=Nuh2vpYKLqe0n8V9slq0EbXLfUpo5ysb \
  -e PROTONVPN_SERVER=CH-MX#1 \
  protonsocks
```

## License
Code released under the [MIT License](https://github.com/LuKks/protonsocks/blob/master/LICENSE).

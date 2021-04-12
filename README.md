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

Create a file named `auth.txt` to set your username and password:
```
nano auth.txt
```
```
MhDEyyypW76rpujJSCw63xGTqjk3WlBS
Nuh2vpYKLqe0n8V9slq0EbXLfUpo5ysb
```

To use NetShield DNS, append a suffix to your username:\
Block malware: `+f1`\
Block malware, ads and trackers: `+f2`\
For example: `MhDEyyypW76rpujJSCw63xGTqjk3WlBS+f2`

Edit `docker-compose.yml` file to choose another ProtonVPN server.\
Default is `AR#7`.

## Run with Compose
Later you can just build and run in foreground:
```
docker-compose up --build
```
Add `-d` to run in background.

## Run without Compose
```
docker run --rm -it --privileged -p 1090:1080 -e PROTONVPN_SERVER=CH-NL#1 (docker build -q .)
```

### Build and Run
In case you want to build without immediately run:
```
docker build -t protonsocks .

docker run --rm -it --privileged -p 1090:1080 -e PROTONVPN_SERVER=CH-NL#1 protonsocks
```

## License
Code released under the [MIT License](https://github.com/LuKks/protonsocks/blob/master/LICENSE).

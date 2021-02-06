# protonsocks

Dockerized ProtonVPN

## Install
It requires Docker and Docker Compose:
```
sh install-docker.sh
```

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

Later you can just build and run in foreground:
```
docker-compose up --build
```

## Tests
```
There is no tests yet.
```

## License
Code released under the [MIT License](https://github.com/LuKks/protonsocks/blob/master/LICENSE).

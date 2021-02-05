# protonsocks

Dockerized ProtonVPN

## Install
It requires Docker and Docker Compose:
```
sh install-docker.sh
```

Get your OpenVPN / IKEv2 credentials:\
https://account.protonvpn.com/account#openvpn

Edit the file `.env` with your OpenVPN username and password:
```
nano .env
```

To use NetShield DNS, append a suffix to your username:\
Block malware: `+f1`\
Block malware, ads, and trackers: `+f2`\
For example: `myusername+f2`

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

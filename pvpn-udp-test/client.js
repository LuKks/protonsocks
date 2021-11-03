const dgram = require('dgram');
const SocksClient = require('socks').SocksClient;
let count = 0;

(async function () {
  for (let k = 0; k < 999999999; k++) {
    (async function () {
      try {
        let client = new SocksClient({
          proxy: { host: '127.0.0.1', port: 1090, type: 5 },
          destination: { host: '0.0.0.0', port: 0 },
          command: 'associate'
        });

        const socket = dgram.createSocket('udp4');

        client.on('error', err => {
          console.error(count++, err);
        });

        client.on('established', info => {
          console.log(info.remoteHost); // { host: '159.203.75.235', port: 44711 }

          for (let i = 0; i < 3000; i++) {
            socket.send(SocksClient.createUDPFrame({
              remoteHost: { host: '134.122.25.235', port: 1337 },
              data: Buffer.from('hello')
            }), info.remoteHost.port, info.remoteHost.host);
          }
        });

        client.connect();
      } catch (err) {
        console.error(count++, err);
      }
    })();

    await sleep(1);
  }
})();

function sleep (ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

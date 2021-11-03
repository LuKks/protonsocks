const dgram = require('dgram');

let server = dgram.createSocket('udp4');
let count = 0;

server.on('message', function (msg, info) {
	if (count % 2000 === 0) {
  	console.log('#%d %s (%d bytes) from %s:%d', count, msg.toString(), msg.length, info.address, info.port);
	}
	count++;

  if (info.address !== '217.138.196.19') {
  	console.log('leak?');
  	process.exit();
  }
});

server.on('listening', function () {
  console.log('udp server is listening');
});

server.bind(1337);

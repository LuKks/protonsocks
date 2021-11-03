const request = require('request-promise');
const SocksProxyAgent = require('socks-proxy-agent');
var socks = require('socksv5');

main();

async function main() {
  let agent = new SocksProxyAgent('socks5://127.0.0.1:1090');

  try {
    let responce = await request({
      uri: 'http://134.122.25.235/',
      agent: agent,
      headers: {
        'User-Agent': 'Request-Promise'
      }
    });

    console.log(responce);
  } catch(err) {
    console.error(err);
  }
}
/*

var client = socks.connect({
  host: 'google.com',
  port: 80,
  proxyHost: '127.0.0.1',
  proxyPort: 1080,
  auths: [ socks.auth.None() ]
}, function(socket) {
  console.log('>> Connection successful');
  socket.write('GET /node.js/rules HTTP/1.0\r\n\r\n');
  socket.pipe(process.stdout);
});

*/

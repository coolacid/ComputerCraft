
var port = 5000

var clientid = "" // Set this to your client id from an application -- http://www.twitch.tv/settings/connections

var path = require('path');
var http = require('http');
var querystring = require('querystring');

http.createServer(function (req, res) {
  httpHandler(req, res);
}).listen(port);
console.log('Server running at on port: ' + port);

function httpHandler(req, res) {
    url = require('url').parse(req.url);
    base = path.basename(url.pathname);
    var hostname = req.headers.host;
    var ipAddr = req.headers["x-forwarded-for"];
    if (ipAddr){
      var list = ipAddr.split(",");
      remoteip = list[list.length-1];
    } else {
      remoteip = req.connection.remoteAddress;
    }
    console.log("request received from: " + remoteip + " to " + base + " | " + hostname)
    if (base == "token") {
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Token should be in your URL above')
    } else {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end('<a href="https://api.twitch.tv/kraken/oauth2/authorize?response_type=token&client_id=' + clientid + '&redirect_uri=http://' + hostname + '/token&scope=channel_subscriptions">start</a>');
    }
}

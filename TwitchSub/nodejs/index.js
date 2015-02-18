
var port = (process.env.PORT || 5000)

var OAUTHKeys = {
    user1: "",
    user2: ""
}
var ips = [
    "127.0.0.1"
]

// Use test file instead of going to twitch
testing = true;

var path = require('path'),
    fs = require('fs')

var http = require('http');
var https = require('https');

http.createServer(function (req, res) {
  httpHandler(req, res);
}).listen(port);

console.log('Server running at on port: ' + port);

function TwitchPost(stream, token, client_res) {
    // console.log('stream: ' + stream + ' | token: ' + token);
    var req_options = {
      host: 'api.twitch.tv',
      port: 443,
      path: '/kraken/channels/' + stream + '/subscriptions',
      method: 'GET',
      headers: {
        'Accept': 'application/vnd.twitchtv.v3+json',
        'Authorization': 'OAuth ' + token
      }
    }

    var preq = https.request(req_options, function(res) {
      var body = '';
      res.setEncoding('utf8');
      res.on('data', function (chunk) {
          body += chunk;
      });
      res.on('end', function() {
        client_res.writeHead(res.statusCode, res.headers);
        client_res.end(body)
      });
    });

    preq.end();
}


function httpHandler(req, res) {
    url = require('url').parse(req.url);
    base = path.basename(url.pathname);
    var ipAddr = req.headers["x-forwarded-for"];
    if (ipAddr){
      var list = ipAddr.split(",");
      remoteip = list[list.length-1];
    } else {
      remoteip = req.connection.remoteAddress;
    }
    console.log("request received from: " + remoteip)
    // Check to see if the remote IP is allowed
    if (ips.indexOf(remoteip) < 0) {
        res.writeHead(300, {'Content-Type': 'text/plain'});
        res.end('Not vaild IP');
    // If we have the OAUTH Key defined above, we're good to go. 
    } else if (base in OAUTHKeys) {
        if (testing) {
            res.writeHead(200, {'Content-Type': 'application/json'});
            var filePath = path.join(__dirname, 'testresponse.json');
            var readStream = fs.createReadStream(filePath);
            readStream.pipe(res);
        } else {
            TwitchPost(base, OAUTHKeys[base], res);
        }
    // IP was allowed, but we don't have the Key. 
    } else {
        res.writeHead(404, {'Content-Type': 'text/plain'});
        res.end('Failed\n');
    }
}

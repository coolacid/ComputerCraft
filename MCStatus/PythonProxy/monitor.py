from mcstatus import MinecraftServer
import SimpleHTTPServer
import SocketServer
import yaml
import json

# To install requirements use: pip install -r requirements.txt

PORT = 8000

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler
FileConfig = open("config.yaml", 'r')
Config = yaml.load (FileConfig)

class RequestHandler (SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
	if self.path.translate(None, "/") in Config.keys():
	    server = MinecraftServer.lookup(Config[self.path.translate(None, "/")])
	    status = server.status()
	    result = {'online': status.players.online, 'latency': status.latency}
	    self.wfile.write(json.dumps(result))
	else:
	    self.wfile.write("Failed")

httpd = SocketServer.TCPServer(("", PORT), RequestHandler)

print "serving at port", PORT
try:
    httpd.serve_forever()
except KeyboardInterrupt:
    pass
httpd.server_close()

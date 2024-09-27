import http.server
import socketserver

PORT = 8000

class CGIHTTPRequestHandler(http.server.CGIHTTPRequestHandler):
    cgi_directories = ["/cgi-bin"]

with socketserver.TCPServer(("", PORT), CGIHTTPRequestHandler) as httpd:
    print(f"Serving at port {PORT}")
    httpd.serve_forever()
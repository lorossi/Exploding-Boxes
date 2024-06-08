"""
Quick and dirty HTTP server to serve the exported files.

Modified from: https://github.com/godotengine/godot/blob/master/platform/web/serve.py
"""

import argparse
import contextlib
import os
import socket
import subprocess
import sys
from http.server import HTTPServer, SimpleHTTPRequestHandler  # type: ignore


class DualStackServer(HTTPServer):
    """Support for both IPv4 and IPv6."""

    def server_bind(self):
        """Override server_bind to enable dual-stack support."""
        # Suppress exception when protocol is IPv4.
        with contextlib.suppress(Exception):
            self.socket.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_V6ONLY, 0)
        return super().server_bind()


class CORSRequestHandler(SimpleHTTPRequestHandler):
    """SimpleHTTPRequestHandler with CORS headers."""

    def end_headers(self):
        """Add CORS headers to the response."""
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        self.send_header("Access-Control-Allow-Origin", "*")
        super().end_headers()


def serve(port, export_folder):
    """Serve the exported files on the given port."""
    # Open the served page in the user's default browser.
    print("Opening the served URL in the default browser")
    os.chdir(export_folder)
    opener = "open" if sys.platform == "darwin" else "xdg-open"
    url = f"http://localhost:{port}"

    # Start the server.
    print(f"Serving on {url}")
    with subprocess.Popen(
        [opener, url],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    ):
        with DualStackServer(("", port), CORSRequestHandler) as httpd:
            httpd.serve_forever()


def main():
    """Script entry point."""
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-p",
        "--port",
        help="port to listen on",
        default=8060,
        type=int,
    )
    parser.add_argument(
        "-f",
        "--folder",
        help="folder to serve",
        default="exports",
    )
    args = parser.parse_args()

    serve(args.port, args.folder)


if __name__ == "__main__":
    main()

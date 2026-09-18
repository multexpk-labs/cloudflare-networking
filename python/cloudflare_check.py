#!/usr/bin/env python3

import json
import socket
import sys
import urllib.request
import urllib.error


def main() -> int:
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <domain>")
        return 2

    domain = sys.argv[1]
    result = {
        "domain": domain,
        "addresses": [],
        "https_status": None,
    }

    try:
        result["addresses"] = sorted(
            {item[4][0] for item in socket.getaddrinfo(domain, 443)}
        )
    except socket.gaierror as exc:
        result["dns_error"] = str(exc)

    try:
        request = urllib.request.Request(
            f"https://{domain}",
            method="HEAD",
            headers={"User-Agent": "multexpk-labs-cloudflare-check/1.0"},
        )
        with urllib.request.urlopen(request, timeout=15) as response:
            result["https_status"] = response.status
            result["final_url"] = response.geturl()
    except urllib.error.HTTPError as exc:
        result["https_status"] = exc.code
    except Exception as exc:
        result["https_error"] = str(exc)

    print(json.dumps(result, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

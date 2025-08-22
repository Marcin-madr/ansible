#!/usr/bin/env python3

import os
import sys
import json
import argparse


HOSTS_DATA = {
    "webservers": {
        "hosts": ["192.168.1.10", "192.168.1.11"],
        "vars": {
            "ansible_user": "ubuntu"
        }
    },
    "_meta": {
        "hostvars": {
            "192.168.1.10": {
                "http_port": 80
            },
            "192.168.1.11": {
                "http_port": 80
            }
        }
    }
}

def main():
    parser = argparse.ArgumentParser(description="Ansible dynamic inventory script")
    parser.add_argument('--list', action='store_true', help='List all hosts')
    parser.add_argument('--host', help='Get variables for a specific host')
    args = parser.parse_args()

    if args.list:
        print(json.dumps(HOSTS_DATA, indent=4))
    elif args.host:
        host_vars = HOSTS_DATA.get('_meta', {}).get('hostvars', {}).get(args.host, {})
        print(json.dumps(host_vars, indent=4))
    else:
        parser.print_help()
        sys.exit(1)

if __name__ == "__main__":
    main()
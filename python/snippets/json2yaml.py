#!/usr/bin/env bash
python3 -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read())))' "$1"

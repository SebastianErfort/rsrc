#!/usr/bin/python3

import subprocess

# Run shell command and capture STDOUT
result = subprocess.run(['ls', '-l'], stdout=subprocess.PIPE)
print(result.stdout.decode('utf-8'))


#!/usr/bin/env bash
# Use gpg symmetric encryption (option -c) to encrypt a file with a password using the default key.
# This will open a prompt for entering a password.
gpg -c "$1"

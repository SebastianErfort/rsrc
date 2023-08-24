#!/usr/bin/env bash

frames='- \ | /'
while true; do
    for f in $frames; do
        printf "\r $f"
        sleep 0.25
    done
done

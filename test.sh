#!/usr/bin/env bash

read OK
if [ "$OK" = "n" ]; then 
    echo "abort installation ..."
    exit 0
fi

echo "yay"
#!/usr/bin/env bash

echo "test text" >> test.txt

echo "+-------------+------------------------+------------------+"
echo "| Mount point | Size                   | Type             |"
echo "+-------------+------------------------+------------------+"
echo "| /boot       | 1 GB (for dualboot)    | EFI System       |"
echo "+-------------+------------------------+------------------+"
echo "| SWAP        | 16 GB (2 x RAM)        | Linux swap       |"
echo "+-------------+------------------------+------------------+"
echo "| /           | 1/3 of free disk space | Linux filesystem |"
echo "+-------------+------------------------+------------------+"
echo "| /home       | 2/3 of free disk space | Linux filesystem |"
echo "+-------------+------------------------+------------------+"
read ok
echo "im running ${ok}"
if [ $ok = "n" ]; then 
    exit 1
fi
read PART_PROF
case "$PART_PROF" in 
    "1")
        echo "first"
        echo "first"
        echo "first"

        echo "first"

        ;;
    "2")
        echo "second"
        ;;
    "3") 
        echo "third"
        ;;
    *)
        echo "exit"
        exit 0
        ;;
esac
echo "hey"
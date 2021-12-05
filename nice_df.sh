#! /bin/bash

# Just a better output for df
df -h | grep -vE 'loop' | grep -vE 'tmpfs' | grep -vE 'udev'

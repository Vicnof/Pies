#!/bin/bash

git fetch --all
git reset --hard origin/main
nohup ./luvit Pies.lua
exit 0

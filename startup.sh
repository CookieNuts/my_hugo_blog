#!/bin/bash
git pull
hugo
nohup hugo server -D >output.log 2>&1 &

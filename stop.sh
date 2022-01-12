#!/bin/bash

pid=$(ps -ef | grep 'hugo server' | grep -v grep | awk '{print $2}');
kill -15 $pid;

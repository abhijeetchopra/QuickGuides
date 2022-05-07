#!/bin/bash
# script to build docker image

# print usage when incorrect arguments passed
if [ $# -ne 1 ]; then
  echo "usage   : $0 <tag>"
  echo ""
  echo "example : $0 0.0.1-rc.1"
  exit 1
fi

docker build -t docker-demo-nginx:$1 .


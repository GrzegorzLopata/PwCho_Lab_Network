#!/bin/bash

docker run -itd --name T1 alpine

docker network create -d bridge --subnet 10.0.10.0/24 bridge1

docker run -itd --name T2 -p 8000:80 -p 10.0.10.0:80:8000 nginx

docker run -itd --name D1 --net bridge1 --ip 10.0.10.254 alpine

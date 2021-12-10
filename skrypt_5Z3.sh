#!/bin/bash

#utworzenie sieci bridge1 i bridge2
docker network create -d bridge --subnet 10.0.10.0/24 bridge1
docker network create -d bridge bridge2

#utworzenie D1 na bazie alpine, przylaczonego do sieci bridge1 + nadanie aliasu
docker run -itd --name D1 --network-alias host1 --net bridge1 --ip 10.0.10.254 alpine

#utworzenie D2 przylaczonego do sieci bridge1
docker run -itd --name D2 --network-alias apa1 --net bridge1 -p 8080:80 -p 8081:80 bitnami/apache

#podlaczenie D2 do bridge2
docker network connect --alias apa2 bridge2 D2

#utworzenie S1 + alias + dodanie do sieci bridge2
docker run -itd --name S1 --net bridge2 --network-alias host2 ubuntu

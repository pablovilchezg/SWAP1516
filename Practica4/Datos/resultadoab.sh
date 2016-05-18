#! /bin/bash

cat abhaproxy.txt | grep -i taken >> resultadoabhaproxy.txt
cat abhaproxy.txt | grep -i failed >> resultadoabhaproxy.txt
cat abhaproxy.txt | grep -i "per second" >> resultadoabhaproxy.txt

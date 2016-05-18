#! /bin/bash

cat siegem1.txt | grep -i Availability >> resultadosiegem1.txt
cat siegem1.txt | grep -i Elapsed >> resultadosiegem1.txt
cat siegem1.txt | grep -i Response >> resultadosiegem1.txt
cat siegem1.txt | grep -i "Transaction rate" >> resultadosiegem1.txt
cat siegem1.txt | grep -i "Failed transactions" >> resultadosiegem1.txt
cat siegem1.txt | grep -i "Longest transaction" >> resultadosiegem1.txt

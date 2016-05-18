#! /bin/bash
for ((i = 0; i < 10; i++))
do
	siege -b -t60s -v http://10.0.0.2/index.php 2>> /home/userka/Escritorio/siegem1.txt
	printf "\n\n\n" >> /home/userka/Escritorio/siegem1.txt
done

#! /bin/bash
for ((i = 0; i < 10; i++))
do
	ab -n 1000 -c 5 http://10.0.0.4/index.php >> /home/userka/Escritorio/abhaproxy.txt
	printf "\n\n\n" >> /home/userka/Escritorio/abhaproxy.txt
done

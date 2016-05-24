#PRACTICA 5


##Creación base de datos MySQL

Para interactuar con MYSQL, abrimos la consola con:

```

mysql -uroot -p

```

Ponemos la contraseña y ya podemos ejecutar comandos. En las siguientes imagenes creamos una base de datos e insertamos tablas y datos.

![mysql](./1mysql.png "Crear base de datos MYSQL")

![mysql2](./2mysqlcreates.png "Insertar datos en base de datos")

##Replicar la BD con MySQLDump

Para replicar manualmente la base de datos podemos usar MySQLDump, que es una herramienta que viene como parte del cliente de MySQL.
Antes de ejecutar tenemos que bloquear las lecturas de la base de datos para poder realizar la copia de seguridad.

```

	mysql -u root -p
	FLUSH TABLES WITH READ LOCK;
	quit

```

Después ya podemos realizar la copia de seguridad con el siguiente comando

```

	mysqldump contactos -u root -p > ./contactos.sql

```

![mysqldump](./3mysqldump.png "Copia de la base de datos")

Finalmente ya podemos desbloquear la base de datos para que se pueda seguir ejecutando y copiamos con SCP el resultado en m2

```

	mysql -u root -p
	UNLOCK TABLES;
	quit
	scp ./contactos.sql root@10.0.0.3:/root/contactos.sql

```

![desbloqueartablas](./4desbloqdb.png "Desbloquear base datos")

Ahora en m2, creamos la base de datos contactos. Ya podemos restaurar la copia en m2

```

	CREATE DATABASE contactos;
	sudo cp /root/contactos.sql /home/useras/contactos.sql
	mysql -u root -p contactos < /home/useras/contactos.sql

```

![backupbdenm2](./5creadbconbackup.png "Hacer backup con la DB")

Por último comprobamos que la base de datos se ha grabado correctamente:

```

	use contactos;
	show tables;
	select * from datos;

```

![copiaok](./6vercopiadbenm2.png "Comprobacion copia DB")

##Replicar la base de datos con maestro-esclavo


Para replicar la base de datos automáticamente, tenemos que cambiar el fichero de configuración con lo siguiente.

En el maestro:

```

	#bind-address 127.0.0.1
	log_error = /var/log/mysql/error.log
	server-id = 1
	log_bin = /var/log/mysql/bin.log

```

En el esclavo:

```

	#bind-address 127.0.0.1
	log_error = /var/log/mysql/error.log
	server-id = 2
	log_bin = /var/log/mysql/bin.log

```

Reiniciamos el servicio en las dos maquinas con:

```

sudo service mysql start

```

Usando *service mysql restart* se reinicia el servicio bien, sin embargo con init.d daba errores como el siguiente, que según he leído, es porque no init.d no cerraba bien el servicio:

![errorinitd](./7errorinitd.png "Error al reiniciar servicio")

Ya podemos crearel maestro esclavo. 
Para el master ejecutamos los siguientes comandos como muestra la siguiente imagen, además de ver el STATUS en el que se queda:

![createesclavo](./8createesclavo.png "Sentencias para master")

En el slave ejecutamos:

![iniciarslave](./9iniciarslave.png "Sentencias para esclavo")

Y vemos el estado del slave, el cual tiene *Seconds_Behind_Master* a cero, que es el estado correcto:

![slavefuncionando](./91slavefuncionando.png "Esclavo funcionando OK")

Ya finalmente nos queda ver cómo cuando creamos nuevas tablas en el master, automáticamente se replican en el slave. Para ello creamos datos2 e incluimos una entrada.

![crearnuevatabla](./92crearnuevatabla.png "Nueva tabla datos2")

Vemos las dos máquinas con los mismos datos, que automáticamente se han replicado en m2:

![replicaenslave](./93replicaenslave.png "Datos replicados en m2")
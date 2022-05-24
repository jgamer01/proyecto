#!/bin/bash
clear
while [ opcion!=0 ]
do
      echo " ";
      echo " ----------------------------------------------------------";
      echo "|                             Menu                         |";
      echo "|----------------------------------------------------------|";
      echo "|                         OPCIONES                         |";
      echo "|----------------------------------------------------------|";
      echo "| 0 - Salir                                                |";
      echo "| 1 - Listar las instancias disponibles                    |";
      echo "| 2 - Crear una instancia		                   |";
      echo "| 3 - Comenzar una instancia                               |";
      echo "| 4 - Pausar una instancia		                   |";
      echo "| 5 - Eliminar una instancia                               |";
      echo "| 6 - Instalar mods			                   |";
      echo " ----------------------------------------------------------";
      read -p "Escoge opcion: " opcion;

      case $opcion in 
	0)
		echo "Saliendo del programa....."
		sleep 2
		exit
		;;

	1)
		echo "Listando las instancias disponibles"
		sleep 2
		podman ps -a
		;;

	2)
		read -p "Cual sera el nombre del servidor : " nombre_srv
		sleep 2
		min_puerto=30000
		max_puerto=31000
		RANGE=$(($max_puerto-$min_puerto))
		RESULT=$RANDOM
		RESULT=$(($RESULT%$RANGE))
		RESULT=$(($RESULT+$min_puerto))
		podman create --name $nombre_srv-minetest -p $puerto:3000/udp docker.io/linuxserver/minetest > /dev/null 
		podman start $nombre_srv-minetest > /dev/null
		echo "Credo correctamente con el puerto $RESULT"
		;;

	3)
		read -p "Cual es el nombre del servidor que desea darle iniciar : " nombre_servidor_start
		podman start $nombre_Srv-minetest
		sleep 2
		;;

	4)
		read -p "cual es el nombre del servidor que desea darle a stop : " nombre_servidor_stop
		podman stop $nombre_servidor_stop-minetest
		sleep 2
		;;

	5)
		read -p "nombre del servidor a eliminar : " nombre_servidor_eliminar
		podman stop $nombre_servidor_eliminar-minetest
		podman rm $nombre_servidor_eliminar-minetest
		sleep 2
		;;

	6)
		echo "esto es una prueba"
		;;
	esac
done

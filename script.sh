#!/bin/bash
clear
while [ opcion_podman != 0 ]
do
      echo " ";
      echo " ----------------------------------------------------------"
      echo "|                             Menu                         |"
      echo "|----------------------------------------------------------|"
      echo "|                         OPCIONES                         |"
      echo "|----------------------------------------------------------|"
      echo "| 1 - Crear instancias			                   |"
      echo "| 2 - Listar servidor	 	                           |"
      echo "| 3 - Iniciar servidor			                   |"
      echo "| 4 - Parar servidor                		           |"
      echo "| 5 - Eliminar servidor                                    |"
      echo " ----------------------------------------------------------"
      read -p "Escoge opcion: " opcion_podman

      case $opcion_podman in 

	1)
		echo " ----------------------------------------------------------"
                echo "|                             Menu                         |"
                echo "|----------------------------------------------------------|"
                echo "|                         Desea que contenga mods?         |"
                echo "|----------------------------------------------------------|"
                echo "| 1 - Si		                                   |"
                echo "| 2 - No                                                   |"
                echo " ----------------------------------------------------------"
		read -p "Introduce si desea o no mods (en numeros los numeros indicados a la izquierda)" opcion_mods_sino
		case $opcion_mods_sino in
		1)
			read -p "Eliga el nombre del servidor" nombre_srv_mods
			while [ mods != 5 ]
                       do
			echo " ----------------------------------------------------------"
	                echo "|                             Menu                         |"
       	        echo "|----------------------------------------------------------|"
                	echo "|                         OPCIONES                         |"
	                echo "|----------------------------------------------------------|"
	                echo "| 1 - Anvil                                                |"
	                echo "| 2 - MoreOres                                             |"
	                echo "| 3 - Piramides                                            |"
	                echo "| 4 - Zombies                                              |"
			echo "| 5 - salir	                                           |"
	                echo " ----------------------------------------------------------"
	                read -p "Introduce las opciones que deseas" mods
			case $mods in
			1)
				cp -r /home/podman/proyecto/mods/anvil/ /home/podman/.local/share/containers/storage/volumes/$nombre_srv_mods
			;;
			2)
				cp -r /home/podman/proyecto/mods/moreores /home/podman/.local/share/containers/storage/volumes/$nombre_srv_mods
			;;
			3)
				cp -r /home/podman/proyecto/mods/zombies /home/podman/.local/share/containers/storage/volumes/$nombre_srv_mods
			;;
			4)
				cp -r /home/podman/proyecto/piramides /home/podman/.local/share/containers/storage/volumes/$nombre_srv_mods
			;;
			5)
				min_puerto=30000
        		        max_puerto=31000
	                	RANGE=$(($max_puerto-$min_puerto))
		                RESULTADO1=$RANDOM
		                RESULTADO1=$(($RESULT%$RANGE))
		                RESULTADO1=$(($RESULT+$min_puerto))
		                podman create -v /home/podman/.local/share/containers/storage/volumes/$nombre_srv_mods  --name $nombre_srv_mods-minetest -p $RESULTADO1:30000/udp docker.io/linuxserver/minetest > /dev/null
		                echo "Credo correctamente con el puerto $RESULT"
				exit
			;;
			esac
			done
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
                podman create --name $nombre_srv-minetest -p $RESULT:30000/udp docker.io/linuxserver/minetest > /dev/null
                echo "Credo correctamente con el puerto $RESULT"
                ;;
		esac
	;;
	2)
		echo "Listando las instancias disponibles"
		sleep 2
		podman ps -a
		;;

	3)
		read -p "Cual es el nombre del servidor que desea darle iniciar : " nombre_srv_start
		podman start $nombre_srv_start-minetest > /dev/null
		sleep 2
		;;

	4)
		read -p "cual es el nombre del servidor que desea darle a stop : " nombre_servidor_stop
		podman stop $nombre_servidor_stop-minetest > /dev/null
		sleep 2
		;;

	5)
		read -p "nombre del servidor a eliminar : " nombre_servidor_eliminar
		podman stop $nombre_servidor_eliminar-minetest > /dev/null
		podman rm $nombre_servidor_eliminar-minetest > /dev/null
		sleep 2
		;;

	esac
done

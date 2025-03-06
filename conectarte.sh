#!/bin/bash

echo "Mostrando interfaces de red disponibles:"
ip link show

echo "Seleccione la interfaz de red (por ejemplo, eth0, wlan0):"
read interfaz

echo "¿Quieres activar o desactivar la interfaz? (up/down):"
read estado

ip link set $interfaz $estado

echo "¿La interfaz seleccionada es cableada (eth) o inalámbrica (wlan)?"
read tipo

if [ "$tipo" = "wlan" ]; then
    echo "Escaneando redes inalámbricas disponibles..."
    sudo iwlist $interfaz scan | grep ESSID

    echo "Ingrese el nombre de la red a la que desea conectarse:"
    read red
    echo "Ingrese la clave de la red (deje en blanco si no tiene contraseña):"
    read clave

    sudo nmcli device wifi connect "$red" password "$clave" ifname $interfaz
else
    echo "¿Desea configurar una IP estática o dinámica?"
    read configuracion

    if [ "$configuracion" = "estatica" ]; then
        echo "Ingrese la dirección IP estática:"
        read ip_estatica
        echo "Ingrese la máscara de subred (por ejemplo, 255.255.255.0):"
        read mascara
        echo "Ingrese la puerta de enlace predeterminada:"
        read gateway
        echo "Ingrese el servidor DNS (opcional):"
        read dns

        sudo ip addr add $ip_estatica/$mascara dev $interfaz
        sudo ip route add default via $gateway
        if [ ! -z "$dns" ]; then
            echo "nameserver $dns" | sudo tee /etc/resolv.conf > /dev/null
        fi
    else
        sudo dhclient $interfaz
    fi
fi

echo "Haciendo la configuración permanente..."
sudo systemctl restart NetworkManager

echo "Configuración completada."

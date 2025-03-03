#!/bin/bash

PAPELERA="$HOME/.trash/"
mkdir -p "$PAPELERA"

ARCHIVO="$1"

if [ ! -e "$ARCHIVO" ]; then
    echo "Error: El archivo '$ARCHIVO' no existe."
    exit 2
fi

mv "$ARCHIVO" "$PAPELERA"
echo "Archivo se movió a la papelera"

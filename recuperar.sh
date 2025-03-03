##!/bin/bash

PAPELERA="$HOME/.trash/"

RECUPERAR="$1"
ARCHIVO_RECUPERADO=$(ls -t "$PAPELERA" | grep "^$RECUPERAR" | head -n 1)

if [ -z "$ARCHIVO_RECUPERADO" ]; then
    echo "Error: No se encontró '$RECUPERAR' en la papelera."
    exit 2
fi

mv "$PAPELERA/$ARCHIVO_RECUPERADO" "$RECUPERAR"
echo "Archivo '$RECUPERAR' restaurado en $(pwd)"


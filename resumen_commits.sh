#!/bin/bash

# Script para generar un resumen de cambios entre dos commits de Git.
# Uso: ./resumen_commits.sh <commit_inicial> <commit_final>

# --- Validación de argumentos ---
if [ "$#" -ne 2 ]; then
    echo "Error: Se requieren exactamente dos argumentos."
    echo "Uso: $0 <commit_inicial> <commit_final>"
    exit 1
fi

COMMIT_INICIAL=$1
COMMIT_FINAL=$2

# --- Encabezado del Resumen ---
echo "================================================================="
echo " Resumen de Cambios: $COMMIT_INICIAL...$COMMIT_FINAL"
echo "================================================================="
echo

# --- Lista de Commits ---
echo ">>> Commits en este rango:"
git log --pretty=format:"- %h %s (%an, %ar)" $COMMIT_INICIAL..$COMMIT_FINAL
echo
echo

# --- Resumen de Archivos Cambiados (Estadísticas) ---
echo ">>> Resumen de cambios en archivos:"
git diff --stat $COMMIT_INICIAL..$COMMIT_FINAL
echo


echo "================================================================="
echo " Fin del Resumen"
echo "================================================================="

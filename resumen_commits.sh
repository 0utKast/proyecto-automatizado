#!/bin/bash

# Script para generar un resumen claro y detallado de cambios entre dos commits.
# Uso: ./resumen_commits.sh <commit_inicial> <commit_final>

# --- Validación de argumentos ---
if [ "$#" -ne 2 ]; then
    echo "Error: Debes proporcionar dos IDs de commit."
    echo "Uso: $0 <commit_inicial> <commit_final>"
    exit 1
fi

COMMIT_INICIAL=$1
COMMIT_FINAL=$2

# --- Verificación de commits ---
if ! git cat-file -e $COMMIT_INICIAL^{commit} 2>/dev/null || ! git cat-file -e $COMMIT_FINAL^{commit} 2>/dev/null; then
    echo "Error: Uno o ambos IDs de commit no son válidos."
    exit 1
fi

# --- Encabezado ---
echo "Resumen de Cambios entre $COMMIT_INICIAL y $COMMIT_FINAL"
echo "-----------------------------------------------------"
echo

# --- Autores Involucrados ---
echo ">> Autores:"
git log --pretty=format:"- %an" $COMMIT_INICIAL..$COMMIT_FINAL | sort -u
echo

# --- Lista de Commits (Resumen) ---
echo ">> Resumen de Commits:"
git log --pretty=format:"* %s (%h)" $COMMIT_INICIAL..$COMMIT_FINAL
echo

# --- Archivos Modificados (Detalle) ---
echo ">> Archivos Modificados:"
git diff --name-status $COMMIT_INICIAL..$COMMIT_FINAL
echo

# --- Estadísticas Generales ---
echo ">> Estadísticas:"
git diff --shortstat $COMMIT_INICIAL..$COMMIT_FINAL
echo
echo "-----------------------------------------------------"
#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -e|--exo)
            $0 `echo "-d exo$2 -c exo_$2"`
            exit 0
            ;;
            
        -d|--directory)
            mkdir "$2"
            cd "$2"
            shift 2
            ;;

        -c|--create) 
            file="$2.c"
            echo "// fichier $file" >> "$file"
            echo >> "$file"
            echo "#include <unistd.h>" >> "$file"
            echo "#include <stdio.h>" >> "$file"
            echo "#include <stdlib.h>" >> "$file"
            echo "" >> "$file"
            echo "int main(int argc, char *argv[])" >> "$file"
            echo "{" >> "$file"
            echo "    return EXIT_SUCCESS;" >> "$file"
            echo "}" >> "$file" 

            echo "# Makefile" >> "Makefile"
            echo "CC = gcc" >> "Makefile"
            echo "CFLAGS = -g -W -Wall -std=c99" >> "Makefile"
            echo "LDFLAGS = " >> "Makefile"
            echo "OBJ = $2.o" >> "Makefile"
            echo "" >> "Makefile"
            echo "$2: \$(OBJ)" >> "Makefile"
            echo -e "\t\$(CC) \$(OBJ) \$(LDFLAGS) -o $2" >> "Makefile"
            echo "" >> "Makefile"
            echo "$2.o : $file" >> "Makefile"
            echo "" >> "Makefile"
            echo "clean :" >> "Makefile"
            echo -e "\trm -f \$(OBJ) $2" >> "Makefile"

            exit 0 
            ;;

        -m|--module)
            echo "// fichier en-tête $2.h" > "$2.h"
            echo "#ifndef __`echo $2`_h__" >> "$2.h"
            echo "#define __`echo $2`_h__" >> "$2.h"
            echo "" >> "$2.h"
            echo "// déclaration des fonctions" >> "$2.h"
            echo "" >> "$2.h"
            echo "#endif " >> "$2.h"

            echo "// fichier $2.c" >> "$2.c"
            echo "" >> "$2.c"
            echo "#include \"$2.h\"" >> "$2.c"

            if [ -e "Makefile" ]; then
                # Lire le fichier ligne par ligne
                while IFS= read -r ligne
                do
                    if [[ "$ligne" == *"OBJ ="* ]]; then
                        echo "$ligne $2.o" >> "Makefile.temp"
                    elif [[ "$ligne" == *".o : "*".c"* ]]; then
                        echo "$2.o : $2.c $2.h" >> "Makefile.temp"
                        echo "$ligne" >> "Makefile.temp"
                    else
                        echo "$ligne" >> "Makefile.temp"
                    fi
                done < "Makefile"

                mv "Makefile.temp" "Makefile"
            fi

            exit 0 ;;

        -h|--help) 
            echo "Utilisation : project-c OPTION [FICHIER]..."
            echo "Création de fichier c et modification du fichier Makefile"
            echo
            echo "Les arguments disponibles sont :"
            echo "  -c, --create        création du fichier .c main et du Makefile"
            echo "  -d, --directory     création d'un répertoire pour la création de fichier"
            echo "  -e, --exo           -d et -c avec le numéro de l'exercice"
            echo "  -h, --help          affichage de l'aide"
            echo "  -m, --module        création d'un fichier module .c + .h et modification du Makefile"
            exit 0 ;;

        *) echo "Option inconnue : $1"; exit 1 ;;
    esac
done

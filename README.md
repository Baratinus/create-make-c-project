# create-make-c-project
Petit script bash pour automatiquement créer des fichiers en C et Makefile (en les remplissants)

Ce script est principalement que des commandes "echo" misent à la suite, sans aucun commentaire :)

# Arguments disponibles
  -c, --create        création du fichier .c main et du Makefile dans le répertoire courant, ou si -d est appliqué avant dans le répertoire indiqué
  -d, --directory     création d'un répertoire pour la création de fichier dans le répertoire courant
  -h, --help          affichage de l'aide
  -m, --module        création d'un fichier module .c + .h et modification du Makefile dans le répertoire courant
                      si aucun fichier "Makefile", alors il n'en crée pas un

# Exemple d'utilisation
./project-c -d exo1 -c exo_1    Création d'un répertoire *exo1* avec à l'intérieur un fichier *exo_1.c* et *Makefile*
./project-c -m module           Création d'un fichier d'entête *module.h* et un fichier *module.c*, et si disponible, modification du *Makefile*

# docker-oracle-xe-11g

Ce projet est basé sur sur https://github.com/wnameless/docker-oracle-xe-11g

Voici les caractéristiques du conteneur contruit ici:

- Ubuntu 18.04
- Oracle Express Edition 11g Release 2
- Le mot de passe `SYSTEM` et `SYS` est `oracle`
- Accès SSH au conteneur (par Putty par exemple), nom d'utilisateur `ubuntu` et mot de passe `ubuntu`
- Éditeur de programmation Vim et Nano installés
- Console ligne de commande Bash et Fish
- Application SQLPlus installé
- Java Oracle version 13 installé (commande `javac` pour compiler et `java` pour exécuter
- Ports 1521 ouvert pour une connection `localhost` avec SQLPlus local ou par SQLDeveloper
- Pilote `ojdbc6.jar` installé pour permettre un accès aux BD Oracle par un programme Java
- Langage Python 3 installé
- Pilote Oracle pour Python 3 `cx_oracle`
- Un programme Java test disponible à `/home/ubuntu/JdbcOracleConnection.java`
- Un programme Python 3 test disponible à `/home/ubuntu/oracleConnection.py`
-


# D'autres conteneurs Oracle

Voir la liste des conteneurs de produits BD Oracle à https://github.com/oracle/docker-images

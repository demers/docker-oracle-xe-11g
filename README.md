# Description du dépôt Git demers/docker-oracle-xe-11g

Ce projet est basé sur https://github.com/wnameless/docker-oracle-xe-11g

Voici les caractéristiques du conteneur contruit ici:

- Ubuntu 18.04+
- Serveur SSH pour se connecter par SSH ou Putty
- Accès SSH au conteneur (par Putty par exemple), nom d'utilisateur `ubuntu` et mot de passe `ubuntu`
- Éditeur de programmation Vim et Nano installés

# Oracle

- Oracle Express Edition 11g Release 2
- Le mot de passe `SYSTEM` et `SYS` est `oracle`
- Console ligne de commande Bash et Fish
- Application SQLPlus installé
- Ports 1521 ouvert pour une connection `localhost` avec SQLPlus local ou par SQLDeveloper

# Java

- Java Oracle version 13 installé (commande `javac` pour compiler et `java` pour exécuter
- Pilote `ojdbc6.jar` installé pour permettre un accès aux BD Oracle par un programme Java

# Python

- Langage Python 3 installé
- Pilote Oracle pour Python 3 `cx_oracle`
- Un programme Java test disponible à `/home/ubuntu/JdbcOracleConnection.java` (voir plus bas pour les exécuter)
- Un programme Python 3 test disponible à `/home/ubuntu/oracleConnection.py` (voir plus bas pour les exécuter)

# MongoDB

- MongoDB et le client Mongo

# Préalables

Vous devez avoir sur votre système:

- Windows Pro et Education (si vous êtes sous Windows)
- Linux (meilleur choix que Windows pour Docker)
- Hyper-V (si vous êtes sous Windows 10)
- Chocolatey (si vous êtes sous Windows 10)
- Docker 17+
- Docker compose 2+
- Au moins 3,5 Go d'espace disque.

# Comment installer Docker et Docker-compose sous Windows

Il faut d'abord activer Hyper-V.  Voir https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v

On installe Docker en suivant les étapes de: https://runnable.com/docker/install-docker-on-windows-10

On installe Chocolatey par les étapes de: https://chocolatey.org/install
(redémarrer votre console PS)

On installe Git par la commande suivante:

```
choco install git
```

On installe Docker-compose en suivant les étapes de: https://docs.docker.com/compose/install/#install-compose
(section Windows Server)

On installe Putty

```
choco install putty
```

# Comment installer ce projet Docker sur votre ordinateur

Vous devez ouvrir une console Bash ou Powershell et exécuter:

```
git clone https://github.com/demers/docker-oracle-xe-11g.git

cd docker-oracle-xe-11g

docker-compose up -d
```

Vous pouvez vous connecter au conteneur par SSH.  Sous Linux, on tape

```
ssh -l ubuntu localhost
```

Sous Windows, vous devez installer [Putty](https://www.putty.org/) et utiliser
le nom du serveur localhost pour le port 22.

Pour arrêter temporairement le conteneur, on tape:

```
docker-compose stop
```

On redémarre le conteneur arrêté par:

```
docker-compose start
```

On détruit le conteneur par:

```
docker-compose down

docker rmi oracle11g
```

On peut faire une copie de sécurité du conteneur par la commande:

```
docker export oracle11g -o oracle11g.tar
```

On importe ensuite une copie par la commande:

```
docker import oracle11g.tar
```

# Comment se connecter à Oracle par SQLPlus de l'intérieur du conteneur

Quand vous êtes connecté au conteneur, pour accéder à la console Oracle, on tape simplement:

```
sqlplus
```

On peut aussi ajouter le nom d'utilisateur et mot de passe:

```
sqlplus SYSTEM/oracle
```


Si on veut se connecter directement au compte SYSTEM, on tape le raccourci
(alias):

```
sp
```

Le programme `rlwrap` est utilisé pour obtenir un historique par la flèche vers
le haut.

# Comment se connecter à Oracle par SQLPlus de l'extérieur du conteneur

## Le conteneur s'exécute localement sur votre ordinateur

Si votre conteneur s'exécute localement sur votre ordinateur et que vous avez
installé SQLPlus ([voir](https://www.oratable.com/sqlplus-instant-client-installation/) pour Windows ou [voir](https://askubuntu.com/questions/159939/how-to-install-sqlplus) pour Ubuntu 18.04), faites la commande:

```
sqlplus SYSTEM/oracle@//localhost:1521/XE
```

## Le conteneur s'exécute à l'extérieur sur un serveur à l'adresse 11.22.33.44

```
sqlplus SYSTEM/oracle@//11.22.33.44:1521/XE
```

# Comment tester le programme Java dans le conteneur

On compile le programme `JdbcOracleConnection.java`:

```
javac JdbcOracleConnection.java
```
On exécute le programme `JdbcOracleConnection`:

```
java -cp classpath/ojdbc6.jar:. JdbcOracleConnection
```

# Comment tester le programme Python 3 dans le conteneur

Pour tester le programme `oracleConnection.py`, on exécute le code simplement
comme suit:

```
python3 oracleConnection.py
```

# Comment installer SQL Developer

Voir https://www.oracle.com/tools/downloads/sqldev-downloads.html

Il se peut que vous ayez besoin de Oracle Java 8 sur votre ordinateur...
Voir https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

Si vous l'installez sous Ubuntu 18.04 ou un équivalent, il vous faut
OpenJDK 8 et vous devez installer JavaFX par la commande:

```
sudo apt install openjdk-8-jdk openjdk-8-jre
```

Voir plus d'info à https://tecadmin.net/install-oracle-java-8-ubuntu-via-ppa/

Vous devez aussi suivre la [procédure suivante](https://github.com/JabRef/user-documentation/issues/204) pour installer JavaFX.

## Comment utiliser SQL Developer avec le conteneur

À venir...

# Comment se connecter au serveur MongoDB

## Windows 10

Vous devez installer le client Mongo comme suit:

N.B.: Il faut installer [Chocolatey](https://chocolatey.org/packages/mongodb).

```
choco install mongodb
```

Il ne faut pas démarrer le serveur MongoDB.

## Ubuntu

Si vous êtes sur Ubuntu, faites:

```
sudo apt install mongodb
```

Ensuite, il faut arrêter le serveur Mongo et le désactiver:

```
sudo systemctl stop mongodb
sudo systemctl disable mongodb
```

## Le conteneur s'exécute localement sur votre ordinateur

```
mongo 127.0.0.1:27017
```

## Le conteneur s'exécute à l'extérieur sur un serveur à l'adresse 11.22.33.44

```
mongo 11.22.33.44:27017
```

# D'autres conteneurs Oracle disponibles officiellement

Voir la liste des conteneurs de produits BD Oracle à https://github.com/oracle/docker-images

# Projet C# Core et Oracle 11g

Voir https://github.com/ericmend/oracleClientCore-2.0

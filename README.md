# Description du dépôt Git demers/docker-oracle-xe-11g

Ce projet est basé sur https://github.com/wnameless/docker-oracle-xe-11g

Voici les caractéristiques du conteneur contruit ici:

- Ubuntu 18.04+
- Serveur SSH pour se connecter par SSH
- Accès SSH au conteneur, nom d'utilisateur `ubuntu` et mot de passe `ubuntu`
- Éditeur de programmation Vim et Nano installés

# Oracle

- Oracle Express Edition 11g Release 2
- Le mot de passe `SYSTEM` et `SYS` est `oracle`
- Console ligne de commande Bash et Fish
- Application SQLPlus installé
- Ports 49161 ouvert pour une connection `localhost` avec SQLPlus local ou par SQLDeveloper

# Java

- Java Oracle version 13 installé (commande `javac` pour compiler et `java` pour exécuter)
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
- (optionnel) Linux (meilleur choix que Windows pour Docker)
- Chocolatey (si vous êtes sous Windows 10)
- Docker 17+
- Docker compose 2+
- Au moins 3,5 Go d'espace disque
- Désactiver votre parefeu
- Désactiver votre antivirus.

# Comment installer Docker et Docker-compose sous Windows

ATTENTION: Vous devez Windows PRO ou Education.  Sinon, faites le passage à PRO
par exemple, voir cette méthode https://www.lifewire.com/upgrade-windows-10-home-to-pro-4178259

Vous devez vous assurer que l'option de virtualisation dans votre BIOS est bien
activée.

On installe Docker en suivant les étapes de: https://docs.docker.com/toolbox/toolbox_install_windows/

On installe Chocolatey par les étapes de: https://chocolatey.org/install
(redémarrer votre console PS)

On installe Git par la commande suivante:

```
choco install git
```

On installe Docker-compose en suivant les étapes de: https://docs.docker.com/compose/install/#install-compose
(section Windows Server)

On active la commande SSH en suivant les étapes décrites dans ce guide: https://www.howtogeek.com/336775/how-to-enable-and-use-windows-10s-built-in-ssh-commands/

# Comment installer ce projet Docker sur votre ordinateur

Vous devez ouvrir une console Bash ou Powershell et exécuter:

```
git clone https://github.com/demers/docker-oracle-xe-11g.git

cd docker-oracle-xe-11g

docker-compose up -d
```

Vous pouvez vous connecter au conteneur par [Putty](https://www.putty.org/) et utiliser
le nom du serveur localhost pour le port 2222 (pas 22).


Si vous êtes sous Linux, on tape

```
ssh -p 2222 -l ubuntu localhost
```

Pour arrêter temporairement le conteneur (par exemple, à la fin de votre
travail), on tape:

```
docker-compose stop
```

On redémarre le conteneur arrêté (pour reprendre vos travaux) par:

```
docker-compose start
```

On détruit le conteneur par:

```
docker-compose down

docker rmi oracle11g
```

On peut faire une copie de sécurité du conteneur par la commande (3 Go au moins
du fichier généré):

```
docker export oracle11g -o oracle11g.tar
```

On importe ensuite une copie par la commande:

```
docker import oracle11g.tar
```

# Comment installer SQL Plus client sur votre ordinateur

## Windows

Voir les explications à https://www.oratable.com/sqlplus-instant-client-installation/

## Ubuntu

Voir les explications à https://webikon.com/cases/installing-oracle-sql-plus-client-on-ubuntu

# Comment se connecter à Oracle par SQLPlus de l'intérieur du conteneur

Quand vous êtes connecté au conteneur (par Putty ou SSH), pour accéder à la console Oracle, on tape simplement:

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

N.B.: Le programme `rlwrap` est utilisé pour obtenir un historique par la flèche vers
le haut.

# Comment se connecter à Oracle par SQLPlus de l'extérieur du conteneur

## Le conteneur s'exécute localement sur votre ordinateur

Si votre conteneur s'exécute localement sur votre ordinateur et que vous avez
installé SQLPlus ([voir](https://www.oratable.com/sqlplus-instant-client-installation/) pour Windows ou [voir](https://askubuntu.com/questions/159939/how-to-install-sqlplus) pour Ubuntu 18.04), faites la commande:

```
sqlplus SYSTEM/oracle@//localhost:49161/XE
```

## Le conteneur s'exécute à l'extérieur sur un serveur à l'adresse 11.22.33.44

```
sqlplus SYSTEM/oracle@//11.22.33.44:49161/XE
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

## Sous Windows 10

Téléchargez le choix avec JDK 8 inclus à https://www.oracle.com/tools/downloads/sqldev-downloads.html

Vous décompressez par exemple dans `C:\SQLDeveloper` et vous exécutez
l'exécutable dans le dossier.

Si vous avez des problèmes, consultez https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/sqldev-install-windows-1969674.html

## Ubuntu

Si vous l'installez sous Ubuntu 18.04 ou un équivalent, il vous faut
OpenJDK 8 et vous devez installer JavaFX par la commande:

```
sudo apt install openjdk-8-jdk openjdk-8-jre
```

Voir plus d'info à https://tecadmin.net/install-oracle-java-8-ubuntu-via-ppa/

Vous devez aussi suivre la [procédure suivante](https://github.com/JabRef/user-documentation/issues/204) pour installer JavaFX.

## Comment utiliser SQL Developer avec le conteneur

Après installation sans erreur de SQL Developer, créez une nouvelle connexion en utilisant le nom
d'utilisateur `SYSTEM` et mot de passe `oracle`.  Le nom de l'hôte est
`localhost` et le port est 49161.  Le SID est `xe`.  Il n'y a rien d'autre
à changer.

# Comment se connecter au serveur MongoDB

## Windows 10

Vous devez installer le client Mongo comme suit:

N.B.: Il faut installer [Chocolatey](https://chocolatey.org/packages/mongodb).

```
choco install mongodb
```

Il ne faut pas démarrer le serveur MongoDB.  Rien à faire ici.

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
mongo 127.0.0.1:27000
```

## Le conteneur s'exécute à l'extérieur sur un serveur à l'adresse 11.22.33.44

```
mongo 11.22.33.44:27000
```

# D'autres conteneurs Oracle disponibles officiellement

Voir la liste des conteneurs de produits BD Oracle à https://github.com/oracle/docker-images

# Projet C# Core et Oracle 11g

Voir https://github.com/ericmend/oracleClientCore-2.0

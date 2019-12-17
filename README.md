# Description du dépôt Git demers/docker-oracle-xe-11g

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
- Un programme Java test disponible à `/home/ubuntu/JdbcOracleConnection.java` (voir plus bas pour les exécuter)
- Un programme Python 3 test disponible à `/home/ubuntu/oracleConnection.py` (voir plus bas pour les exécuter)

# Comment se connecter à Oracle par SQLPlus

Pour se connecter à Oracle, on tape simplement:

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

# Comment tester le programme Java

On compile le programme `JdbcOracleConnection.java`:

```
javac JdbcOracleConnection.java
```
On exécute le programme `JdbcOracleConnection`:

```
java -cp classpath/ojdbc6.jar:. JdbcOracleConnection
```

# Comment tester le programme Python 3

Pour tester le programme `oracleConnection.py`, on exécute le code simplement
comme suit:

```
python3 oracleConnection.py
```

# D'autres conteneurs Oracle disponibles officiellement

Voir la liste des conteneurs de produits BD Oracle à https://github.com/oracle/docker-images

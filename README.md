#  Mise en place d'une solution de virtualisation des postes de travail avec Apache Guacamole

## Contexte et objectifs

Face à l'évolution des besoins en télétravail et en sécurité informatique, ce projet vise à déployer une solution open-source de virtualisation des postes de travail, basée sur **Apache Guacamole** et **Docker**, permettant un accès distant sécurisé via navigateur web, sans installation côté client.

###  Objectifs :
- Fournir un accès distant sécurisé aux machines Windows et Linux
- Centraliser la gestion des accès utilisateurs
- Utiliser uniquement des outils open-source : Docker, Guacamole, MySQL
- Assurer une installation rapide, scalable et maintenable

---

##  Prérequis techniques

- Un serveur Linux (Ubuntu 22.04 recommandé)
- Docker & Docker Compose installés
- Ports ouverts : `8080` (HTTP), `3389` (RDP), `5901` (VNC)
- Droits `sudo` et accès SSH

---

##  Architecture technique

```plaintext
+-----------------+         +-------------+
|  Client Web     | <--->   |  Guacamole  |
|  (navigateur)   |         | Web App     |
+-----------------+         +------+------+
                                  |
                                  v
                            +-----+------+
                            |   guacd    |
                            +-----+------+
                                  |
                     +------------+------------+
                     |                         |
             +-------+-------+         +-------+-------+
             | Connexion RDP |         | Connexion VNC |
             +---------------+         +---------------+
```

### Connexions distantes configurées côté serveur

Les connexions vers les postes de travail (Windows via RDP et Linux via VNC) ont été directement **ajoutées à la base de données MySQL** à l'aide de requêtes SQL et non via l'interface graphique.

Ces connexions permettent un accès sécurisé, avec :
- Des paramètres personnalisés (IP, résolution, couleurs, mot de passe, etc.)
- Un contrôle d'accès par utilisateur
- Une simplicité de gestion côté administrateur

---

### Aperçu visuel

Les captures d’écran illustrant chaque étape sont disponibles dans le dossier guacamole-screenshots.zip
[Télécharger le fichier ZIP](projet-virtualisation/screenshots./guacamole-screenshots.zip)


---

### Sécurité & supervision

- Modification des identifiants par défaut
- Ajout d’utilisateurs avec droits restreints
- Configuration du pare-feu (UFW)
- Reverse proxy sécurisé avec Nginx + HTTPS (Let’s Encrypt)
- Sauvegarde régulière de la base de données Guacamole

---

### Références

- [Documentation officielle Apache Guacamole](https://guacamole.apache.org/)
- [Docker Hub - Guacamole](https://hub.docker.com/u/guacamole)

---

##  Réalisé par

Projet réalisé dans le cadre du module de virtualisation à l’**EMSI Marrakech**, sous la supervision de **Pr. Abdeljalil NADIRI**.
Par :
ISSAME Imad
AGOUMI Mohammed Amine
HABIBI Abdollah
ABDULAAL Najd
"""


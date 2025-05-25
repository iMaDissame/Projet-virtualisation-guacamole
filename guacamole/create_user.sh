#!/bin/bash
# Paramètres
USERNAME="$1"
PASSWORD="$2"

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo "Usage: $0 <username> <password>"
    echo "Exemple: $0 monuser monmotdepasse"
    exit 1
fi

echo "Création de l'utilisateur $USERNAME..."

# Générer un salt aléatoire
SALT=$(openssl rand -hex 16)

# Créer le hash du mot de passe
PASSWORD_HASH=$(echo -n "${PASSWORD}${SALT}" | sha256sum | cut -d' ' -f1)

# Se connecter à MySQL et créer l'utilisateur
docker exec -i mysql mysql -u root -proot_pass guacamole_db << SQL
-- Créer l'entité utilisateur
INSERT INTO guacamole_entity (name, type) VALUES ('$USERNAME', 'USER');

-- Récupérer l'ID de l'entité créée
SET @entity_id = LAST_INSERT_ID();

-- Créer l'utilisateur avec le hash du mot de passe
INSERT INTO guacamole_user (entity_id, password_hash, password_salt, password_date, disabled, expired, full_name) 
VALUES (@entity_id, UNHEX('$PASSWORD_HASH'), UNHEX('$SALT'), NOW(), 0, 0, '$USERNAME');

-- Récupérer l'ID de l'utilisateur créé
SET @user_id = LAST_INSERT_ID();

-- Permissions de base
INSERT INTO guacamole_system_permission (entity_id, permission) 
VALUES (@entity_id, 'CREATE_CONNECTION');

INSERT INTO guacamole_system_permission (entity_id, permission) 
VALUES (@entity_id, 'CREATE_CONNECTION_GROUP');

SELECT CONCAT('Utilisateur créé - Entity ID: ', @entity_id, ', User ID: ', @user_id) as 'Résultat';
SQL

echo "Utilisateur $USERNAME créé avec succès!"

#!/bin/bash
USERNAME="$1"
PASSWORD="$2"

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo "Usage: $0 <username> <password>"
    exit 1
fi

echo "Correction du mot de passe pour $USERNAME..."

# Méthode simple sans salt (comme guacadmin par défaut)
PASSWORD_HASH=$(echo -n "$PASSWORD" | sha256sum | cut -d' ' -f1)

docker exec -i mysql mysql -u root -proot_pass guacamole_db << SQL
UPDATE guacamole_user 
SET password_hash = UNHEX('$PASSWORD_HASH'), 
    password_salt = NULL,
    password_date = NOW()
WHERE entity_id = (SELECT entity_id FROM guacamole_entity WHERE name = '$USERNAME');

SELECT 'Mot de passe mis à jour' as 'Résultat';
SQL

echo "Mot de passe de $USERNAME corrigé!"

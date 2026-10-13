#!/bin/bash

# CloudNova Backup Script

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$PROJECT_DIR/backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p "$BACKUP_DIR"
cd "$PROJECT_DIR"

echo "Starting CloudNova backup..."

# Back up the MariaDB database
sudo docker compose exec -T db sh -c 
  'exec mariadb-dump -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' \
  > "$BACKUP_DIR/database_$DATE.sql"

if [ ! -s "$BACKUP_DIR/database_$DATE.sql" ]; then
    echo "ERROR: Database backup is empty."
    exit 1
fi

# Back up Nextcloud application files
sudo docker compose exec -T app tar -czf - -C /var/www/html . \
  > "$BACKUP_DIR/nextcloud_$DATE.tar.gz"

if [ ! -s "$BACKUP_DIR/nextcloud_$DATE.tar.gz" ]; then
    echo "ERROR: Nextcloud backup is empty."
    exit 1
fi

echo "CloudNova backup completed successfully."
echo "Backup files are in: $BACKUP_DIR"

# Remove backup files older than 7 days
find "$BACKUP_DIR" -type f -mtime +7 -delete

echo "Old backups cleaned up."

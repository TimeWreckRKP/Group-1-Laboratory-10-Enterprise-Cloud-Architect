
#!/usr/bin/env bash

# CloudNova Backup Script
# Group 1 - Mission 10

set -Eeuo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$PROJECT_DIR/backups"
DATE="$(date +'%Y-%m-%d_%H-%M-%S')"

mkdir -p "$BACKUP_DIR"
cd "$PROJECT_DIR"

echo "Starting CloudNova backup..."

# Back up the MariaDB database
sudo docker compose exec -T db sh -c \
  'exec mariadb-dump --single-transaction -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' \
  > "$BACKUP_DIR/database_${DATE}.sql"

if [ ! -s "$BACKUP_DIR/database_${DATE}.sql" ]; then
    echo "ERROR: Database backup is empty." >&2
    exit 1
fi

# Back up Nextcloud application files
sudo docker compose exec -T app tar -czf - -C /var/www/html . \
  > "$BACKUP_DIR/nextcloud_${DATE}.tar.gz"

if [ ! -s "$BACKUP_DIR/nextcloud_${DATE}.tar.gz" ]; then
    echo "ERROR: Nextcloud backup is empty." >&2
    exit 1
fi

# Check the compressed archive
tar -tzf "$BACKUP_DIR/nextcloud_${DATE}.tar.gz" > /dev/null

echo "Backup completed successfully."
echo "Backup files are stored in: $BACKUP_DIR"

ls -lh "$BACKUP_DIR/database_${DATE}.sql" \
       "$BACKUP_DIR/nextcloud_${DATE}.tar.gz"

# Delete backup files older than seven days
find "$BACKUP_DIR" -type f -mtime +7 -delete

echo "Old backups cleaned up."

# CloudNova Operational Manual

**Project:** Mission 10 — The Enterprise Cloud Architect  
**Group:** Group 1  
**Application:** Nextcloud + MariaDB  
**Server:** Ubuntu Server

## 1. Introduction

This manual explains how our team deploys, secures, operates, and maintains CloudNova. Our application uses Docker Compose to manage Nextcloud and MariaDB on an Ubuntu Server virtual machine.

The purpose of this manual is to help our team and future administrators understand the system configuration and perform common maintenance tasks.

## 2. System Architecture

Our host computer runs Oracle VirtualBox, which hosts the Ubuntu Server virtual machine. Docker runs two containers:

- **Nextcloud:** Provides the web application.
- **MariaDB:** Stores the application database.

The containers communicate through a private Docker network. Docker named volumes store the database and Nextcloud application files. UFW controls incoming network traffic, while our Bash script creates backups.

The architecture diagram is stored in `architecture-diagram.png`.

## 3. Requirements

Before deployment, prepare the following:

- Ubuntu Server virtual machine with internet access.
- Docker Engine and Docker Compose plugin.
- The files `docker-compose.yml`, `.env`, and `automation-script.sh`.
- Sufficient disk space for application data and backups.
- A host-to-VM networking configuration that allows browser access.

## 4. Prepare the Environment

Create a private `.env` file in the same directory as `docker-compose.yml`.

The file must contain these variables:

```env
MYSQL_ROOT_PASSWORD=replace_with_a_strong_root_password
MYSQL_PASSWORD=replace_with_a_strong_app_password
MYSQL_DATABASE=nextcloud
MYSQL_USER=nextcloud
```

Replace both example passwords with strong, unique passwords. Do not commit the real `.env` file to GitHub.

Restrict access to the file:

```bash
chmod 600 .env
```

## 5. Deploy the Application

Open a terminal in the project directory and validate the configuration:

```bash
sudo docker compose config
```

Start the containers:

```bash
sudo docker compose up -d
```

Check their status:

```bash
sudo docker compose ps
```

View application and database logs:

```bash
sudo docker compose logs --tail=100
```

Open the application in a browser using `http://<VM-IP>:8080`, or use the host address and port configured in VirtualBox port forwarding.

During the initial Nextcloud setup, select the MySQL/MariaDB database option. Use the database name, username, and password from `.env`. Set the database host to `db`.

## 6. Persistent Storage

Our Docker Compose file defines two named volumes:

- `db_data` stores MariaDB database files.
- `nextcloud_data` stores Nextcloud application files.

List the available Docker volumes:

```bash
sudo docker volume ls
```

Restart the services:

```bash
sudo docker compose restart
```

Check that the application still works and that existing data remains.

**Warning:** Do not use `docker compose down -v` during routine maintenance. The `-v` option removes declared named volumes and may delete important data.

A reboot-persistence test should also be performed on the Ubuntu VM before this requirement is marked complete.

## 7. Firewall Configuration

UFW provides host-based firewall protection. The following commands are an example for a server requiring SSH and web access on port 8080:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw allow 8080/tcp
sudo ufw enable
sudo ufw status verbose
```

Only permit the ports needed by the actual deployment. Do not expose the MariaDB port 3306 publicly. It is not published by our Compose configuration.

If web access is intended only from the host computer, restrict the VirtualBox port-forwarding rule to `127.0.0.1` and avoid exposing the service to other networks unnecessarily.

## 8. Run the Backup Script

Make the script executable:

```bash
chmod +x automation-script.sh
```

Run it manually:

```bash
./automation-script.sh
```

The script uses Docker Compose to export the MariaDB database and archive the Nextcloud application directory. It checks that the generated files are not empty and checks the compressed archive.

List the backup files:

```bash
ls -lh backups/
```

The script removes backup files older than seven days. Keep backup files outside the GitHub repository.

**Important:** A successful backup command does not prove that a complete restoration will work. The backup and restore process must be tested in a safe test environment. A production-grade backup plan should coordinate the database and file backups and include all necessary configuration and data.

## 9. Schedule the Script with Cron

Open the current user's Cron table:

```bash
crontab -e
```

Add this example line to schedule the script every day at 2:00 AM:

```cron
0 2 * * * /absolute/path/to/automation-script.sh >> /absolute/path/to/backups/cron.log 2>&1
```

Replace both example paths with the actual absolute paths on the Ubuntu Server.

Check the saved schedule:

```bash
crontab -l
```

Check whether Cron is running:

```bash
sudo systemctl status cron
```

Test the scheduled job and inspect its log. The backup script uses `sudo docker compose`, so confirm that the scheduled user can run the required Docker commands non-interactively. Do not configure broad passwordless sudo permissions just to make the job work.

## 10. Troubleshooting

### Containers are not running

```bash
sudo docker compose ps
sudo docker compose logs --tail=100
```

### Application cannot connect to the database

Check that both services are running and review the environment variables and logs. The database host in the application configuration should be `db`.

### Web application cannot be reached

Check the container status, UFW rules, VM IP address, and VirtualBox port-forwarding configuration.

```bash
sudo ufw status verbose
sudo docker compose ps
```

### Backup script fails

Confirm that Docker is running, both containers are running, the script is executable, and the command is being run from the project directory.

### Cron job does not run

Check the Cron table, service status, log file, absolute paths, and permissions.

## 11. Maintenance Checklist

- Check container health and logs regularly.
- Monitor available disk space.
- Review UFW rules after network changes.
- Check that scheduled backups are being created.
- Test restoration in a separate environment.
- Keep passwords and other secrets out of GitHub.
- Record actual test results and unresolved issues.

## 12. Conclusion

This manual documents the main deployment, security, storage, and backup procedures for our CloudNova laboratory project. We will update it when the configuration changes and verify each procedure on the actual server before claiming it has passed testing.

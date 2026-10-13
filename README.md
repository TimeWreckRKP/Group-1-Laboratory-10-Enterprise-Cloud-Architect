# Group 1 — Enterprise Cloud Architect

**Laboratory Activity 10: Mission 10 — The Enterprise Cloud Architect**

## 1. Project Overview

Our team developed CloudNova, a containerized web application environment using Nextcloud and MariaDB. This project is part of our final cloud computing laboratory activity, where we apply the concepts we learned throughout the course.

Our goal is to deploy a working multi-tier application, protect the server using firewall rules, maintain persistent data storage, automate backups, and document the system so that our team can maintain and redeploy it.

## 2. Project Objectives

- Design a cloud infrastructure architecture.
- Deploy Ubuntu Server using a virtual machine.
- Install Docker and Docker Compose.
- Run Nextcloud and MariaDB as connected containers.
- Configure persistent storage using Docker volumes.
- Apply firewall rules using UFW.
- Create a Bash script for database and application backups.
- Schedule automated backups using Cron.
- Maintain a shared GitHub repository containing our project files and documentation.
- Prepare our infrastructure for the live deployment and defense.

## 3. Technologies Used

- Ubuntu Server 24.04
- Oracle VirtualBox
- Docker
- Docker Compose
- Nextcloud
- MariaDB
- UFW Firewall
- Bash scripting
- Cron
- GitHub

## 4. System Architecture

Our infrastructure uses a host computer running Oracle VirtualBox, which hosts an Ubuntu Server virtual machine. Docker runs the application containers inside the VM.

The Nextcloud application communicates with the MariaDB database through a private Docker network. Docker named volumes provide persistent storage for application and database data. UFW controls incoming network traffic, while our Bash backup script creates database and application file backups.

The architecture diagram and deployment evidence will be included in the `docs/` directory.

## 5. Application Deployment

Our selected application stack is Nextcloud with MariaDB. Docker Compose defines the services, environment variables, network, restart policies, and persistent volumes used by the application.

The web interface is accessed through port 8080 using the VirtualBox port-forwarding configuration on our development computer.

## 6. Security Configuration

We configured UFW with a default-deny incoming policy and allowed SSH and TCP port 8080 for administration and application access.

We will document and verify the final firewall rules and network configuration as part of our security evidence.

Database credentials are managed through a local `.env` file. Real credentials must not be committed to this public repository.

## 7. Backup and Automation

Our Bash backup script backs up the MariaDB database and Nextcloud application files into a local backup directory. The script checks that the generated backup files are not empty and removes old backup files according to its retention rule.

We will document the Cron schedule and verify that automatic execution works before marking this requirement complete.

## 8. Repository Contents

This repository will contain our Docker Compose configuration, sample environment configuration, Bash scripts, architecture diagram, screenshots, operational manual, and final reflection.

## 9. Team Collaboration

This project is a group requirement. We will use this shared repository to organize our work, document our progress, review changes, and record each member's actual contributions.

See `GROUP_MEMBERS.md` for our team members and responsibilities.

## 10. Live Defense

Our team will prepare to deploy the infrastructure in a fresh KillerCoda environment and explain the application architecture, container configuration, persistent storage, security rules, and backup automation.

## 11. Conclusion

Through this project, our team aims to apply our knowledge of Linux administration, virtualization, containerization, security, automation, and technical documentation. We will use our deployment tests and evidence to verify that the infrastructure meets the requirements of Mission 10.

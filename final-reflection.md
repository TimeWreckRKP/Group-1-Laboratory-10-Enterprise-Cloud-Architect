# Final Reflection — Mission 1 to Mission 10

## 1. Introduction

Throughout Missions 1 to 10, our group learned about cloud computing, Linux administration, networking, virtualization, containers, security, and automation. In Mission 10, we combined these concepts to design and document our CloudNova infrastructure using Ubuntu Server, Docker Compose, Nextcloud, and MariaDB.

## 2. What We Learned

We learned that building an infrastructure requires more than installing an application. We need to plan the architecture, configure the network, manage the server, protect incoming connections, and make sure important data is stored safely. We also learned how Docker Compose makes it easier to manage multiple connected containers using one configuration file.

## 3. Our Architecture and Deployment

For our project, we selected Nextcloud and MariaDB. Nextcloud provides the web application, while MariaDB stores the database. We connected them through a private Docker network and configured persistent volumes for application and database data.

Using VirtualBox allowed us to run Ubuntu Server on our computer and access the web application through the configured network. This helped us understand how the different infrastructure components work together.

## 4. Security and Automation

We applied the concepts of host-based security by configuring UFW with a default-deny incoming policy and allowing only the ports required for administration and application access.

We also created a Bash script to back up the database and Nextcloud application files. Cron can execute the script automatically according to a schedule. These tasks helped us understand why security, regular backups, and testing are important for maintaining a reliable system.

## 5. Challenges and Teamwork

During this project, we needed to understand how the containers communicate, how persistent volumes work, and how to organize the project files and documentation. Working as a group also required us to coordinate tasks and review the system together.

**Our actual challenge and solution:** [Add a real problem your group encountered and explain how you solved it.]

## 6. Improvements We Would Make

If we continued developing CloudNova, we would improve monitoring, test the complete restoration process, protect the application with HTTPS, and consider storing backups outside the server. We would also review firewall rules regularly and improve the automation logs.

## 7. Conclusion

Mission 10 helped us connect the concepts from our earlier missions into one infrastructure project. We gained a better understanding of how Linux, virtualization, networking, Docker, security, persistent storage, and automation work together. We also learned that good documentation and testing are necessary so another administrator can maintain the system.

[Before submitting, revise this reflection to include your group's actual test results, experiences, and contributions. Remove or change any statement that does not reflect what you actually completed.]

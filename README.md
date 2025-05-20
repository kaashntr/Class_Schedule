[# Class chedule
## General info
This repository contains a source code of the Class Schedule Project.

The main goal of the project is designing a website where the university or institute staff will be able to create, store and display their training schedules.

Link to the development version of the site: https://develop-softserve.herokuapp.com/

## Dockerless

## Creating a local repository
In order to create a local copy of the project you need:
1. Download and install the last version of Git https://git-scm.com/downloads
2. Open a terminal and go to the directory where you want to clone the files. 
3. Run the following command. Git automatically creates a folder with the repository name and downloads the files there.

       git clone https://github.com/kaashntr/internship_project.git

## PostgreSQL
1. Download and install the last version of PostgreSQL https://www.postgresql.org/download/
2. Configure your username, password and connection url in `src/main/resources/hibernate.properties` file
3. Create USER in db with:

       CREATE USER tomcat WITH PASSWORD 'your_password_here';

4. Create DATABASE for user with:

       CREATE DATABASE schedule OWNER tomcat;

5. Grant All Privileges with:

       GRANT ALL PRIVILEGES ON DATABASE schedule TO tomcat;
       GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tomcat;


## Redis
1. Download and install the last version of Redis  https://redis.io/download
2. Configure connection url in `src/main/resources/cache.properties` file

## MongoDB
1. Download and install last version of MongoDB https://www.mongodb.com/docs/manual/administration/install-on-linux/
2. Configure connection url in `src/main/resources/mongo.properties` file

## Starting backend server with Tomcat
1. Install OpenJDK 11

       sudo apt update
       sudo apt install openjdk-11-jdk

3. Install Gradle 6.8

       wget https://services.gradle.org/distributions/gradle-6.8-bin.zip
       unzip gradle-6.8-bin.zip -d /opt/gradle
       echo "export PATH=/opt/gradle/gradle-6.8/bin:$PATH" >> ~/.bashrc
       source ~/.bashrc
       gradle -v

5. Install Tomcat 9.0.50

       sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
       cd /tmp
       curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz
       sudo mkdir /opt/tomcat
       sudo tar -xzvf apache-tomcat-9.0.85.tar.gz -C /opt/tomcat --strip-components=1
       sudo chown -R tomcat: /opt/tomcat
       sudo chmod +x /opt/tomcat/bin/*.sh
       sudo nano /etc/systemd/system/tomcat.service
       # Copy this in opened file:
       [Unit]
       Description=Apache Tomcat 9
       After=network.target

       [Service]
       Type=forking

       User=tomcat
       Group=tomcat

       Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
       Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
       Environment="CATALINA_HOME=/opt/tomcat"
       Environment="CATALINA_BASE=/opt/tomcat"
       Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
       Environment="JAVA_OPTS=-Djava.security.egd=file:/dev/./urandom"

       ExecStart=/opt/tomcat/bin/startup.sh
       ExecStop=/opt/tomcat/bin/shutdown.sh

       Restart=on-failure

       [Install]
       WantedBy=multi-user.target

       sudo systemctl daemon-reexec
       sudo systemctl daemon-reload
       sudo systemctl start tomcat
       sudo systemctl enable tomcat

       sudo systemctl status tomcat

       
       
   
7. Change or add maxPostSize in Tomcat server.xml to maxPostSize="10485760" or more
8. Run this in project directory:

       gradle clean war

9. If everything went well in build/libs/ will be "class_schedule.war" which u need rename as "ROOT.war"
10. Then u need to delete /opt/tomcat/webapps/ROOT and copy build/libs/ROOT.war to this folder

## Starting frontend server using Node.js
1. Download and install Node.js 14.17.4 LTS version https://nodejs.org/en/
2. Create .env file in /frontend and add:

       REACT_APP_API_BASE_URL=http://localhost:8080/
   
4. Open a terminal in `/frontend` directory of the downloaded project and run the following command.

       npm install
   
5. After the installation is finished run the following command to start the frontend server

       npm start

set -e
script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "\e[35m RepoUpdatation\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
if [ $? -eq 0 ];
   then
     echo SUCCESS
   else
     echo FAIL
 fi
yum install nodejs -y
#useradd roboshop
mkdir -p /app


curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
rm -rf /app/*
cd /app/
unzip /tmp/catalogue.zip

npm install

cp ${script_location}/files/catalogue.conf /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue

cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host localhost </app/schema/catalogue.js


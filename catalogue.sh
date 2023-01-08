source=common.sh

echo -e "\e[35m RepoUpdatation\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

echo -e "\e[35m Installation NodeJS\e[0m"
yum install nodejs -y &>>${LOG}
status_check

#echo -e "\e[35m useradd\e[0m"
#useradd roboshop &>>${LOG}
#status_check

echo -e "\e[35m Directory creation\e[0m"
mkdir -p /app &>>${LOG}
status_check

echo -e "\e[35m Downloading webcontent\e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
status_check

echo -e "\e[35m cleanup\e[0m"
rm -rf /app/* &>>${LOG}
status_check

echo -e "\e[35m Change directory\e[0m"
cd /app/ &>>${LOG}
status_check

echo -e "\e[35m Unzip\e[0m"
unzip /tmp/catalogue.zip &>>${LOG}
status_check

echo -e "\e[35m NPM installation\e[0m"
npm install &>>${LOG}
status_check

cp ${script_location}/files/catalogue.conf /etc/systemd/system/catalogue.service &>>${LOG}

echo -e "\e[35m systemd-reload\e[0m"
systemctl daemon-reload &>>${LOG}
status_check

echo -e "\e[35m starting Catalogue\e[0m"
systemctl enable catalogue &>>${LOG}
systemctl start catalogue &>>${LOG}
status_check

echo -e "\e[35m Schema-load\e[0m"
cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

echo -e "\e[35m Shell Install\e[0m"
yum install mongodb-org-shell -y &>>${LOG}
status_check

echo -e "\e[35m hostsetup\e[0m"
mongo --host localhost </app/schema/catalogue.js &>>${LOG}
status_check


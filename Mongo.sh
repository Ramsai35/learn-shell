source common.sh

echo -e "\e[35m Changing direction command\e[0m"
cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

echo -e "\e[35m Changing direction command\e[0m"
yum install mongodb-org -y &>>${LOG}
status_check

echo -e "\e[35m Changing Port status\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
status_check

echo -e "\e[35m enable Mongodb\e[0m"
systemctl enable mongod &>>${LOG}
status_check

echo -e "\e[35m start Mongodb\e[0m"
systemctl start mongod &>>${LOG}
status_check

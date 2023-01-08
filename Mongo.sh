source common.sh

print_head "Changing Dir"
cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "install Mongodb"
yum install mongodb-org -y &>>${LOG}
status_check

print_head "Changing Port Status"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
status_check

print_head "Enable MongoDB"
systemctl enable mongod &>>${LOG}
status_check

print_head "Start Mongodb"
systemctl start mongod &>>${LOG}
status_check

source common.sh
print_head "install Nginx"
yum install nginx -y &>>${LOG}
status_check

print_head "enable Nginx"
systemctl enable nginx &>>${LOG}
status_check

print_head "start Nginx"
systemctl start nginx &>>${LOG}
status_check

print_head "removing file"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_head "Downloading webcontent"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

print_head "Downloading web content"
cd /usr/share/nginx/html &>>${LOG}
status_check

print_head "UNZIP"
unzip /tmp/frontend.zip &>>${LOG}
status_check

print_head "changing dir"
cp ${script_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_head "Restart Nginx"
systemctl restart nginx &>>${LOG}
status_check
source common.sh
echo -e '\e[32m install nginx\e[0m'
yum install nginx -y &>>${LOG}
status_check

echo -e '\e[32m enable nginx\e[0m'
systemctl enable nginx &>>${LOG}
status_check

echo -e '\e[32m start nginx\e[0m'
systemctl start nginx &>>${LOG}
status_check

echo -e '\e[32m cleanup nginx\e[0m'
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

echo -e '\e[32m downloading webcontent\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

echo -e '\e[32m downloading webcontent\e[0m'
cd /usr/share/nginx/html &>>${LOG}
status_check

echo -e '\e[32m unzip webcontent\e[0m'
unzip /tmp/frontend.zip &>>${LOG}
status_check

echo -e '\e[32m changing direction\e[0m'
cp ${script_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

echo -e '\e[32m restart nginx\e[0m'
systemctl restart nginx &>>${LOG}
status_check
script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e '\e[32m install nginx\e[0m'
yum install nginx -y &>>${LOG}
echo $?

echo -e '\e[32m start nginx\e[0m'
systemctl enable nginx &>>${LOG}
echo $?

systemctl start nginx &>>${LOG}
echo $?

echo -e '\e[32m cleanup nginx\e[0m'
rm -rf /usr/share/nginx/html/* &>>${LOG}
echo $?

echo -e '\e[32m downloading webcontent\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
echo $?
cd /usr/share/nginx/html &>>${LOG}

unzip /tmp/frontend.zip &>>${LOG}

cp ${script_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}


systemctl restart nginx &>>${LOG}
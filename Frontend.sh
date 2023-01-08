script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e '\e[32m install nginx\e[0m'
yum install nginx -y &>>${LOG}
if [ $? -eq 0 ];
   then
      echo success
   else
      echo Fail
fi

echo -e '\e[32m enable nginx\e[0m'
systemctl enable nginx &>>${LOG}
echo $?

echo -e '\e[32m start nginx\e[0m'
systemctl start nginx &>>${LOG}
echo $?

echo -e '\e[32m cleanup nginx\e[0m'
rm -rf /usr/share/nginx/html/* &>>${LOG}
echo $?

echo -e '\e[32m downloading webcontent\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
echo $?

cd /usr/share/nginx/html &>>${LOG}

echo -e '\e[32m unzip webcontent\e[0m'
unzip /tmp/frontend.zip &>>${LOG}
echo $?

cp ${script_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}

echo -e '\e[32m restart nginx\e[0m'
systemctl restart nginx &>>${LOG}
echo $?
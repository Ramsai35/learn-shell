script_location=$(pwd)

cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y

sed -i -e '/127.0.0.1/0.0.0.0' /etc/mongod.conf

systemctl enable mongod
systemctl start mongod
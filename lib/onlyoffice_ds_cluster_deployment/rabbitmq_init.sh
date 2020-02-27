apt-get -y update
apt-get -y install rabbitmq-server
rabbitmqctl add_user onlyoffice onlyoffice
rabbitmqctl set_user_tags onlyoffice administrator
rabbitmqctl set_permissions -p / onlyoffice ".*" ".*" ".*"
rabbitmq-plugins enable rabbitmq_management

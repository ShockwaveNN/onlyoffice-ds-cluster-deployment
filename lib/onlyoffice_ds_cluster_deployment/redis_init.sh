apt-get -y update
apt-get -y install redis
sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/" /etc/redis/redis.conf
sed -i "s/protected-mode yes/protected-mode no/" /etc/redis/redis.conf
systemctl restart redis

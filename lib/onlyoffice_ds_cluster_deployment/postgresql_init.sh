apt-get -y update
apt-get -y install postgresql-10
sed -i "s/.*listen_addresses.*/listen_addresses='*'/" /etc/postgresql/10/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/10/main/pg_hba.conf
systemctl restart postgresql
sudo -u postgres psql -c "create database onlyoffice;"
sudo -u postgres psql -c "create user onlyoffice with encrypted password 'onlyoffice';"
sudo -u postgres psql -c "grant all privileges on database onlyoffice to onlyoffice;"

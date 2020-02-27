apt-get -y install nfs-kernel-server
mkdir -pv /var/nfs/general
chown nobody:nogroup /var/nfs/general
echo "/var/nfs/general    *(rw,no_root_squash,no_subtree_check) " > /etc/exports
systemctl restart nfs-kernel-server
touch /var/nfs/general/test_touch

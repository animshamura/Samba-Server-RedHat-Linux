yum install samba samba-client samba-common

firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --reload

cp /etc/samba/smb.conf /etc/samba/smb.conf.orig

mkdir -p /srv/samba/shamura

chmod -R 0775 /srv/samba/shamura

chown -R nobody:nobody /srv/samba/shamura

chcon -t samba_share_t /srv/samba/shamura

vi /etc/samba/smb.conf

testparm

systemctl enable smb.service
systemctl enable nmb.service
systemctl start smb.service
systemctl start nmb.service

groupadd smbgrp
usermod radiantfleak -aG smbgrp
smbpasswd -a radiantfleak


mkdir -p /srv/samba/secure
chmod -R 0770 /srv/samba/secure
chown -R root:smbgrp /srv/samba/secure
chcon -t samba_share_t /srv/samba/secure

vi /etc/samba/smb.conf

testparm
systemctl restart smb.service
systemctl restart nmb.service






```bash

sudo apt install tftpd-hpa

sudo systemctl restart tftpd-hpa

sudo useradd tftp

sudo mkdir /r/tftp -p
sudo chown tftp:tftp /r/tftp
sudo chmod 777 /r/tftp


cat > /etc/default/tftpd-hpa << EOF
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/r/tftp"
TFTP_ADDRESS="0.0.0.0:5069"
TFTP_OPTIONS="--create --secure -vvv"
EOF

```
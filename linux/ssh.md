# client

```bash

# generate key
ssh-keygen -t rsa


nano ~/.ssh/config
Host www.domain.com www2.domain.com
port 77
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_local

```

# server

```bash

sudo apt install openssh-server
mkdir -p ~/.ssh/
sudo nano /etc/ssh/sshd_config


StrictModes no
PermitRootLogin yes

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile      .ssh/rsa_pub #rsa_pub pub key file

PasswordAuthentication no

AllowUsers USER1 USER2

sudo systemctl restart sshd

```

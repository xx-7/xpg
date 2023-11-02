# use

```bash
export {http,https,ftp,rsync,all}_proxy=socks5://127.0.0.1:11028
export {HTTP,HTTPS,FTP,RSYNC,ALL}_PROXY=socks5://127.0.0.1:11028

export {http,https,ftp,rsync,all}_proxy=http://172.17.0.1:11018
export {http,https,ftp,rsync,all}_proxy=http://127.0.0.1:11018

```

# ssh port forward

```bash
ssh -f -N -D 0.0.0.0:8080 root@HOST

```

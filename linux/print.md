# cups

```bash

sudo pacman -S cups

# kde 在系统设置里 Printers界面
sudo pacman -S print-manager

# drivers
# https://wiki.archlinux.org/title/CUPS/Printer-specific_problems

# http://localhost:631/printers/
sudo systemctl restart cups

sudo systemctl disable cups

# http://localhost:631/help/admin.html
# Command-Line Printer Administration
# 支持模块
lpinfo -m

# 已连接
lpinfo -v

lpadmin -x $NAME

lpadmin -p $NAME -E -v $LINK -m $MODELNAME


```

# epson

```bash

paru -S epson-inkjet-printer-escpr

lpadmin -p L4168 -E -v lpd://10.8.8.184:515/PASSTHRU -m lsb/usr/epson-inkjet-printer-escpr/Epson-L4160_Series-epson-escpr-en.ppd

# Coustom build
# source  http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX

./configure --prefix=/usr && make && sudo make install

# Err

# WARNING: 'automake-1.15' is missing on your system.
autoreconf -ivf

# /usr/bin/install: cannot create regular file '/usr/local/lib/libescpr.so.1.0.0': Permission denied
sudo make install

# Idle - "File "/usr/lib/cups/filter/epson-escpr-wrapper" not available: No such file or directory"
cp /usr/local/lib/cups/filter/epson-escpr-wrapper /usr/lib/cups/filter/

```
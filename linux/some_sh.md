```bash

# clean and run

#!/bin/sh

ps -ef | grep 'propdir' | grep -v grep | awk '{print $2}' | xargs kill -9

rm -rf /opt/propdir/logs/*

cd /opt/propdir/bin &&  ./startup.sh


```

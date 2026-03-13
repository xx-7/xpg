# systemd

```bash

cat >> /opt/timer.sh << EOF
#!/bin/bash

echo "`date` run timer!!!"  >> /tmp/timer.log

exit 0
EOF


chmod +x /opt/timer.sh

cat >> /usr/lib/systemd/system/god-timer.service << EOF
[Unit]
Description=go timer.sh

[Service]
ExecStart=/bin/bash /opt/timer.sh
EOF

sudo systemctl restart god-timer

cat >> /usr/lib/systemd/system/god.timer << EOF
[Timer]
OnBootSec=3s
OnUnitActiveSec=5s
AccuracySec=1s
Unit=god-timer.service

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl restart god.timer

# OnBootSec: 启动时间 Time spans can be in seconds (s), minutes (min, m), hours (h), etc. (e.g., OnBootSec=5h 30min)
# OnUnitActiveSec: 执行间隔 s, m, h, day, week
# AccuracySec: 时间精度 1s, 500ms, 1us




```
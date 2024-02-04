#!/bin/bash

# build resmon
gcc /app/src/main.c -o /usr/local/sbin/resmond

# start rsyslog.service
if systemctl is-active --quiet rsyslog.service; then #FIXME: for some reason this returns 3 even if service is active
    echo "rsyslog.service already running"
else
    echo "Starting rsyslog.service"
    systemctl start rsyslog.service
fi

# create resmond.service
echo "Creating resmond.service in systemd"
cat << EOF > /etc/systemd/system/resmond.service
[Unit]
Description=Resmon backend
After=multi-user.target

[Service]
Type=simple
ExecStart=/app/resmond.sh start
ExecStop=/app/resmond.sh stop
TimeoutStopSec=infinity

[Install]
WantedBy=default.target
EOF

# reload units
echo "Reloading units"
systemctl daemon-reload

# start resmond.service
echo "Starting resmond.service"
systemctl start resmond.service && echo "Started resmond.service"

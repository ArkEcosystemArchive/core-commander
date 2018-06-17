#!/usr/bin/env bash

redis_start ()
{
    heading "Starting Redis..."

    sudo systemctl start redis-server >> "$commander_log" 2>&1

    redis_status

    success "Started Redis!"
}

redis_stop ()
{
    heading "Stopping Redis..."

    sudo systemctl stop redis-server >> "$commander_log" 2>&1

    redis_status

    success "Stopped Redis!"
}

redis_restart ()
{
    heading "Restarting Redis..."

    sudo systemctl restart redis-server >> "$commander_log" 2>&1

    redis_status

    success "Restarted Redis!"
}

redis_install ()
{
    heading "Installing Redis..."

    yes "" | sudo add-apt-repository ppa:chris-lea/redis-server | tee -a "$commander_log"
    sudo apt-get update >> "$commander_log" 2>&1
    sudo apt-get -y install redis-server | tee -a "$commander_log"

    if [[ ! -e /etc/rc.local ]]; then
        sudo sh -c "touch /etc/rc.local"
        sudo sh -c "chmod +x /etc/rc.local"
    fi

    sudo sed -i '/exit 0/iecho never > /sys/kernel/mm/transparent_hugepage/enabled\n' /etc/rc.local
    (echo "vm.overcommit_memory=1" | sudo tee -a /etc/sysctl.conf) | tee -a "$commander_log"
    (echo "net.core.somaxconn=65535" | sudo tee -a /etc/sysctl.conf) | tee -a "$commander_log"

    (echo never | sudo tee /sys/kernel/mm/transparent_hugepage/enabled) | tee -a "$commander_log"
    sudo sysctl -p /etc/sysctl.conf | tee -a "$commander_log"

    sudo systemctl enable redis-server | tee -a "$commander_log"

    redis_start

    success "Installed Redis!"
}

redis_status ()
{
    local status=$(pgrep -x redis-server)

    if [[ -z "$status" ]]; then
        STATUS_REDIS="Off"
    else
        STATUS_REDIS="On"
    fi
}

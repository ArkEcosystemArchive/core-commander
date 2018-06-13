#!/usr/bin/env bash

pm2_install ()
{
    heading "Installing PM2 Modules..."

    pm2 install pm2-logrotate >> "$commander_log" 2>&1

    pm2 set pm2-logrotate:max_size 500M >> "$commander_log" 2>&1
    pm2 set pm2-logrotate:compress true >> "$commander_log" 2>&1
    pm2 set pm2-logrotate:retain 7 >> "$commander_log" 2>&1

    success "Installed PM2 Modules!"
}

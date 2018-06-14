#!/usr/bin/env bash

pm2_install ()
{
    heading "Installing PM2 Modules..."

    pm2 install pm2-logrotate | tee -a "$commander_log"

    pm2 set pm2-logrotate:max_size 500M | tee -a "$commander_log"
    pm2 set pm2-logrotate:compress true | tee -a "$commander_log"
    pm2 set pm2-logrotate:retain 7 | tee -a "$commander_log"

    success "Installed PM2 Modules!"
}

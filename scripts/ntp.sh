#!/usr/bin/env bash

ntp_start ()
{
    heading "Starting NTP..."

    sudo systemctl start ntp >> "$commander_log" 2>&1

    ntp_status

    success "Started NTP!"
}

ntp_stop ()
{
    heading "Stopping NTP..."

    sudo systemctl stop ntp >> "$commander_log" 2>&1

    ntp_status

    success "Stopped NTP!"
}

ntp_restart ()
{
    heading "Restarting NTP..."

    sudo systemctl restart ntp >> "$commander_log" 2>&1

    ntp_status

    success "Restarted NTP!"
}

ntp_install ()
{
    # TODO: remove container usage
    if [[ "$CONTAINER" -eq 1 ]]; then
        info "Your host is running in LXC or OpenVZ container. NTP is not required."
    else
        ntp_status

        if [[ "$STATUS_NTP" = "Off" ]]; then
            heading "Installing NTP..."

            sudo apt-get install ntp -yyq | tee -a "$commander_log"
            ntp_stop
            sudo ntpd -gq | tee -a "$commander_log"
            wait_to_continue
            ntp_start
            wait_to_continue

            ntp_status

            if [[ "$STATUS_NTP" = "Off" ]]; then
                error "NTP failed to start! It should be installed and running for ARK."
                error "Check /etc/ntp.conf for any issues and correct them first! Exiting."
                exit 1
            fi

            success "Installed NTP!"
        fi
    fi
}

ntp_status ()
{
    local status=$(sudo pgrep -x ntpd)

    if [[ -z "$status" ]]; then
        STATUS_NTP="Off"
    else
        STATUS_NTP="On"
    fi
}

#!/usr/bin/env bash

check_and_recommend_reboot ()
{
    if [ -f /var/run/reboot-required ]; then
        warning "A reboot is required to complete the system update. It is recommended to reboot now."
        read -p "Reboot system? [Y/n] : " choice
        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            success "The system will restart now."
            sudo reboot
        fi
    fi
}

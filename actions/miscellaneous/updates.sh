#!/usr/bin/env bash

miscellaneous_install_updates ()
{
    ascii

    heading "Checking for system updates..."

    available_updates=$(/usr/lib/update-notifier/apt-check 2>&1 | cut -d ";" -f 1)
    security_updates=$(/usr/lib/update-notifier/apt-check 2>&1 | cut -d ";" -f 2)

    if [[ "$available_updates" == 0 ]]; then
        STATUS_SYSTEM_UPDATE="No"

        success "There are no system updates available."
    else
        STATUS_SYSTEM_UPDATE="Yes"

        warning "There are $available_updates system updates available. $security_updates of them are security updates!"

        read -p "Do you want to update? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            STATUS_SYSTEM_UPDATE="No"

            heading "Updating the system..."

            sudo apt-get update >> "$commander_log" 2>&1
            sudo apt-get upgrade -yqq | tee -a "$commander_log"
            sudo apt-get dist-upgrade -yq | tee -a "$commander_log"
            sudo apt-get autoremove -yyq | tee -a "$commander_log"
            sudo apt-get autoclean -yq | tee -a "$commander_log"

            success "All system dependencies have been updated!"

            check_and_recommend_reboot
            press_to_continue
        fi
    fi

    get_versions
}

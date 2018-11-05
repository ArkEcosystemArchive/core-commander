#!/usr/bin/env bash

core_configure_log_level ()
{
    ascii

    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    info "Which log level would you like to configure?"

    validLevels=("debug" "info" "warning" "error")

    select opt in "${validLevels[@]}"; do
        case "$opt" in
            "debug")
                local inputLevel=debug
                break
            ;;
            "info")
                local inputLevel=info
                break
            ;;
            "warning")
                local inputLevel=warning
                break
            ;;
            "error")
                local inputLevel=error
                break
            ;;
            *)
                echo "Invalid option $REPLY"
            ;;
        esac
    done

    sed -i -e "s/ARK_LOG_LEVEL=$ARK_LOG_LEVEL/ARK_LOG_LEVEL=$inputLevel/g" "$envFile"

    . "$envFile"
}

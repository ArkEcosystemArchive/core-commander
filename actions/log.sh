#!/usr/bin/env bash

utils_log ()
{
    clear

    if [[ ! -d "$CORE_PATH_LOG" ]]; then
        ascii

        error "Log folder does not exist."

        return 1
    fi

    local log_file=$(ls -t "${CORE_PATH_LOG}" | head -n 1)

    if [[ ! -e "${CORE_PATH_LOG}/${log_file}" ]]; then
        ascii

        error "Log file does not exist."

        return 1
    else
        echo -e "\n$(text_yellow " Use Ctrl+C to return to menu")\n"

        trap : INT

        tail -fn 50 "${CORE_PATH_LOG}/${log_file}"
    fi
}

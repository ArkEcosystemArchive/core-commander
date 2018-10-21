#!/usr/bin/env bash

utils_log ()
{
    clear

    local log_dir="${CORE_DATA}/logs/core/${CORE_NETWORK}/"

    if [[ ! -d "$log_dir" ]]; then
        ascii

        error "Log folder does not exist."

        return 1
    fi

    local log_file=$(ls -t "${log_dir}" | head -n 1)

    if [[ ! -e "${log_dir}/${log_file}" ]]; then
        ascii

        error "Log file does not exist."

        return 1
    else
        echo -e "\n$(text_yellow " Use Ctrl+C to return to menu")\n"

        trap : INT

        tail -fn 50 "${log_dir}/${log_file}"
    fi
}

#!/usr/bin/env bash

process_monitor ()
{
    clear
    echo -e "\n$(text_yellow " Use Ctrl+C to return to menu")\n"
    trap : INT

    pm2 monit
}

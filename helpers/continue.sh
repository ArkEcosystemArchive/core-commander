#!/usr/bin/env bash

press_to_continue ()
{
    read -n 1 -s -r -p "$(text_blue "    Press any key to continue")"
}

wait_to_continue ()
{
    sleep 1
}

#!/usr/bin/env bash

if [[ "$BASH_VERSINFO" < 4 ]]; then
    abort 1 "You need at least bash-4.0 to run this script."
fi

if [[ "$(id -u)" = "0" ]]; then
    abort 1 "This script should NOT be started using sudo or as the root user!"
fi

if [[ -z "$HOME" ]]; then
    abort 1 "\$HOME is not defined. Please set it first."
fi

if [[ $(systemd-detect-virt -c) != "none" ]]; then
    clear
    divider
    echo "$(text_red "                    OpenVZ / LXC / Virtuoso Container detected!                  ")"
    echo "$(text_red "                                                                                 ")"
    echo "$(text_red "     Running ARK Core on a Container based virtual system is not recommended!    ")"
    echo "$(text_red "   Please change your VPS provider with one that uses hardware Virtualization.   ")"
    echo "$(text_red "                                                                                 ")"
    echo "$(text_red "                            This script will now exit!                           ")"
    divider
    exit 1
fi

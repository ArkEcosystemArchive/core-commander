#!/usr/bin/env bash

set_locale ()
{
    if [[ $(locale -a | grep ^en_US.UTF-8) ]] || [[ $(locale -a | grep ^en_US.utf8) ]]; then
        if ! $(grep -E "(en_US.UTF-8)" "$HOME/.bashrc"); then
            # Setting the bashrc locale
            echo "export LC_ALL=en_US.UTF-8" >> "$HOME/.bashrc"
            echo "export LANG=en_US.UTF-8" >> "$HOME/.bashrc"
            echo "export LANGUAGE=en_US.UTF-8" >> "$HOME/.bashrc"

            # Setting the current shell locale
            export LC_ALL="en_US.UTF-8"
            export LANG="en_US.UTF-8"
            export LANGUAGE="en_US.UTF-8"
        fi
    else
        # Install en_US.UTF-8 Locale
        sudo locale-gen en_US.UTF-8
        sudo update-locale LANG=en_US.UTF-8

        # Setting the current shell locale
        export LC_ALL="en_US.UTF-8"
        export LANG="en_US.UTF-8"
        export LANGUAGE="en_US.UTF-8"

        # Setting the bashrc locale
        echo "export LC_ALL=en_US.UTF-8" >> "$HOME/.bashrc"
        echo "export LANG=en_US.UTF-8" >> "$HOME/.bashrc"
        echo "export LANGUAGE=en_US.UTF-8" >> "$HOME/.bashrc"
    fi
}

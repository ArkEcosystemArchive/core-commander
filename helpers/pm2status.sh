#!/usr/bin/env bash

pm2status ()
{
   echo $(pm2 describe $1 2>/dev/null)
}

#!/usr/bin/env bash

pm2status ()
{
   echo $(pm2 status | grep -E "(^| )$1( |$)")
}

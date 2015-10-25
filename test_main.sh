#!/bin/bash

source functions

sshkey_select
printf "key label = %s\n" $KEYLABEL
printf "key id    = %s\n" $KEYID

exit


cpu_core_select
printf "Core = %s\n" $CORE

dc_select
printf "DC = %s\n" $DC_LOCATION

ram_select
printf "RAM = %d\n" $RAM

link_select
printf "LINK = %d\n" $NIC

os_select
printf "OS = %s\n" $OS
printf "PS = %s\n" $POST_INSTALL_SCRIPT




string_input 5 "サーバー名"
printf "=======\n"
printf "INPUT: %s\n" $STRING
printf "=======\n"


yn_input "これで良いですか?"
if [ $? == 0 ]; then
    printf "\nOK\n"
else
    printf "\nNG\n"
fi

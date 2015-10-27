#!/bin/bash
source functions

PS3='メニュー番号を選択してください '
DOMAIN="takara.org"
server_cancel
exit




printf "VSI ID = %s\n" $SELECTED_ID
printf "VSI NAME = %s\n" $SELECTED_NAME
yn_input "続行しますか？"
if [ $? == 0 ]; then
    printf "\nOK\n"
else
    printf "\nNG\n"
fi

echo "slcli  --really vs cancel $SELECTED_ID"
slcli --format raw dns record-list $DOMAIN --record $SELECTED_NAME | while read line; do
    a=( `echo $line` )
    DOM_ID="${a[0]}"
    if [ $DOM_ID != "" ]; then
	echo "slcli --really dns record-remove $DOM_ID"
    fi
done





exit

sshkey_select
printf "key label = %s\n" $KEYLABEL
printf "key id    = %s\n" $KEYID

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

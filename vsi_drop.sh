#!/bin/bash
#
#


source functions
string_input 12 "仮想サーバー名"
HOSTNAME=$STRING


# ========== 設定 ==========

# ここのホスト名で判定して、存在すればIDを拾って再ロード
#HOSTNAME=test1
DOMAIN=takara.org

# 表示
printf "===========================================\n"
printf "HOSTNAME :    %s\n" $HOSTNAME
printf "DOMAINNAME :  %s\n" $DOMAIN
printf "===========================================\n"

# ========== 処理 ==========

#
# 削除
#
VSREC=(`slcli --format raw vs list --hostname $HOSTNAME`)
ID=${VSREC[0]}
PRIVATE_IP=${VSREC[3]}

if [ $ID != "" ]; then
    printf "仮想サーバーの削除 $ID\n"
    slcli --really vs cancel $ID
fi

# DNSに同じIPアドレスが存在するかチェック、もし在ったら削除
DNSREC=(`slcli --format raw dns record-list $DOMAIN --data $PRIVATE_IP`)
ID=${DNSREC[0]}
if [ ${DNSREC[0]} != "" ]; then
    printf "仮想サーバーのDNSレコード削除 $ID\n"
    slcli --really --format raw dns record-remove $ID
fi



# 仮想サーバーのリスト
slcli vs list --hostname $HOSTNAME
# ドメインの登録リスト
slcli dns record-list $DOMAIN --record $HOSTNAME



#!/bin/bash
#
# SoftLayerで仮想サーバーのホスト名リストから、
# 同じホスト名がある場合はOSを再ロード
# 既存同一ホスト名が無い場合は、新規作成（オーダー）
#
#
source functions


# ドメイン名インプット
string_input 20 "ドメイン名"
DOMAIN=$STRING
#DOMAIN=takara.org

# ホスト名インプット
string_input 12 "仮想サーバー名"
HOSTNAME=$STRING
#HOSTNAME=test1

#
# slcli vs create-options から設定名を拾う
#
dc_select
#DC_LOCATION=tok02

#
# CPUコア数、メモリGB、NIC bps　
#
cpu_core_select
#CORE=1

ram_select
#RAM=1

link_select
#NIC=100


#
# OSの種類に合わせてコメント箇所を変える
#
os_select
BASEURL=https://raw.githubusercontent.com/takara9/ProvisioningScript/master
#OS=UBUNTU_14_64
#POST_INSTALL_SCRIPT="$BASEURL/ubuntu_basic_config"
#OS=CENTOS_6_64
#POST_INSTALL_SCRIPT="$BASEURL/centos_basic_config"
#OS=CENTOS_7_64
#POST_INSTALL_SCRIPT="$BASEURL/centos_basic_config"
#OS=DEBIAN_8_64
#POST_INSTALL_SCRIPT="$BASEURL/debian_basic_config"


# slcli sshkey list で表示される中から選択する
sshkey_select
#SSHKEYID=370981


# 表示
printf "===========================================\n"
printf "HOSTNAME :    %s\n" $HOSTNAME
printf "DOMAINNAME :  %s\n" $DOMAIN
printf "DATACENTER :  %s\n" $DC_LOCATION
printf "CPU Cores :   %d\n" $CORE
printf "RAM :         %dMB\n" $RAM
printf "Link Speed :  %dMbps\n" $NIC
printf "OS :          %s\n" $OS
printf "Script URL:   %s\n" $POST_INSTALL_SCRIPT
printf "SSH-KEY ID:   %d\n" $SSHKEYID
printf "===========================================\n"

# 確認
yn_input "これで良いですか?"
if [ $? == 1 ]; then
    printf "\n終了します\n"
    exit 0
fi


# ========== 処理 ==========
create_or_restart_vsi $HOSTNAME $DOMAIN $DC_LOCATION $CORE $RAM $OS $POST_INSTALL_SCRIPT $SSHKEYID $NIC
dns_registration $HOSTNAME $DOMAIN 


# === 結果表示 ===
# 仮想サーバーのリスト
slcli vs list --hostname $HOSTNAME
# ドメインの登録リスト
slcli dns record-list $DOMAIN --record $HOSTNAME



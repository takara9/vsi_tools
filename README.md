# vsi_tools

ソフトレイヤーのslcliコマンドをメニュー形式で、
仮想サーバーの作成、削除などを実行する簡単便利ツールです。

```
~/vsi_tools$ ./easy_menu 

= VSI CONFIG ==============================
DATACENTER :  tok02
DOMAINNAME :  takara.org
HOSTNAME :    tkr01
CPU Cores :   1
RAM :         1024 MB
Link Speed :  100 Mbps
OS :          CENTOS_6_64
Script URL:   https://raw.githubusercontent.com/takara9/ProvisioningScript/master/centos_basic_config
SSH-KEY ID:   370981
===========================================
1) show_vsi_config    5) set_dc		   9) vsi_reload
2) show_vsi_list      6) set_hostname	     10) vsi_cancel
3) show_dns_record    7) set_vsi_config
4) set_domain	            8) vsi_create
メニュー番号を選択してください (0:終了 RET:MENU再表示)  

```
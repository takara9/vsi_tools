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
2) show_vsi_list      6) set_hostname	  10) vsi_cancel
3) show_dns_record    7) set_vsi_config
4) set_domain	      8) vsi_create
メニュー番号を選択してください (0:終了 RET:MENU再表示)  

```

# 前提条件
slcli コマンドがインストールされ設定されている必要があります。

```
$ slcli --version
slcli (SoftLayer Command-line), version 4.1.1
```
slcli コマンドが、ワーニング無しで動作するバージョンとして Python 2.7.10 があります。

```
$ python --version
Python 2.7.10
```

Linuxのディストリビューションにバンドルされるバージョンは、それよる古い場合があるので、pyenvをインストールして、Python 2.710 をインストールします。

```
chef@ChefWs:~/vsi_tools$ pyenv versions
  system
* 2.7.10 (set by /home/chef/.pyenv/version)
```

slcliコマンドに、ユーザー名とパスワードが設定され、ポータルの情報が取得できる事を確認します。 

```
~/vsi_tools$ slcli ticket summary
:........:........................:
: Status :         count          :
:........:........................:
:  Open  : :............:.......: :
:        : :    Type    : count : :
:        : :............:.......: :
:        : : Accounting :   0   : :
:        : :  Billing   :   0   : :
:        : :   Sales    :   0   : :
:        : :  Support   :   0   : :
:        : :   Other    :   0   : :
:        : :   Total    :   0   : :
:        : :............:.......: :
: Closed :          2602          :
:........:........................:
```


# インストール

前提条件が出来ていれば、GitHubからclone するだけです。

```
$ git clone https://github.com/takara9/vsi_tools
```

# 使い方

- 初回起動時は、前回の設定データが無いので、次の様な画面が表示されます。 
- メニュー番号の4〜7を順に設定してVSI CONFIGの内容を設定します。
- 仮想サーバー(Vertual Server Instance)をオーダーは 8) vsi_create
- VSIを削除は 10) vsi_cancel、VSIの再インストールは 9) vsi_reload


```
chef@ChefWs:~/vsi_tools$ ./easy_menu 

= VSI CONFIG ==============================
DATACENTER :  
DOMAINNAME :  
HOSTNAME :    
CPU Cores :   0
RAM :         0 MB
Link Speed :  0 Mbps
OS :          
Script URL:   
SSH-KEY ID:   0
===========================================
1) show_vsi_config    5) set_dc		   9) vsi_reload
2) show_vsi_list      6) set_hostname	  10) vsi_cancel
3) show_dns_record    7) set_vsi_config
4) set_domain	      8) vsi_create
メニュー番号を選択してください (0:終了 RET:MENU再表示)  
```


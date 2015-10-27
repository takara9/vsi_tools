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

## slcli コマンド

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

## DNSゾーン登録

このツールはVSIを起動する際に、ソフトレイヤーのDNSサーバーにホストとIPアドレスを登録します。
そして、削除する際に、DNSから削除します。 
このDNSサーバーに登録するために、予めゾーンを設定しておく必要があります。
ソフトレイヤーのDNSゾーンの登録方法は、https://www.change-makers.jp/post/10346 を参照ねがいます。


## SSH KEY の登録

このツールは、パスワードによるログインではなく、SSH鍵によるログインを利用します。
このため事前にSSH鍵が登録されている必要があります。登録方法は https://www.change-makers.jp/post/10302 にあります。
それから

```
$ ssh-keygen -t rsa -f ~/key/takara1
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/chef/key/takara1.
Your public key has been saved in /home/chef/key/takara1.pub.
The key fingerprint is:
11:51:24:19:c4:56:0c:c1:83:70:14:4a:4c:79:33:3e chef@ChefWs
The key's randomart image is:
+--[ RSA 2048]----+
|   o+++*O@+      |
|   .oo= *o.      |
|    .o +..       |
|      E  .       |
|       .S        |
|                 |
|                 |
|                 |
|                 |
+-----------------+
```
コマンドラインからのSSH KEYの登録

```
$ slcli sshkey add -f takara1.pub takara1
SSH key added: 11:51:24:19:c4:56:0c:c1:83:70:14:4a:4c:79:33:3e
```

登録結果の確認

```
$ slcli sshkey list
:........:...........:.................................................:.......:
:   id   :   label   :                   fingerprint                   : notes :
:........:...........:.................................................:.......:
: 395475 :  takara1  : 11:51:24:19:c4:56:0c:c1:83:70:14:4a:4c:79:33:3e :   -   :
:........:...........:.................................................:.......:
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

## 仮想サーバーのコンフィグ作成
次の例の様に、順番に選択を進めていきます。入力結果は 1) show_vsi_config で確認できます。

```
1) show_vsi_config    5) set_dc		   9) vsi_reload
2) show_vsi_list      6) set_hostname	  10) vsi_cancel
3) show_dns_record    7) set_vsi_config
4) set_domain	      8) vsi_create
メニュー番号を選択してください (0:終了 RET:MENU再表示)  4

ドメイン名 を 20 文字以内でインプットしてください (NULL:終了) > takara.org
ドメイン名　は takara.org で正しいですか?  (y/n) y
メニュー番号を選択してください (0:終了 RET:MENU再表示)  5

データセンターを選択してください
1) tok02
2) sjc03
3) hkg02
メニュー番号を選択してください (0:終了 RET:MENU再表示)  1
メニュー番号を選択してください (0:終了 RET:MENU再表示)  6

仮想サーバー名 を 12 文字以内でインプットしてください (NULL:終了) > www01
仮想サーバー名　は www01 で正しいですか?  (y/n) y
メニュー番号を選択してください (0:終了 RET:MENU再表示)  7

CPUコア数を選択してください
1) 1
2) 2
3) 4
メニュー番号を選択してください (0:終了 RET:MENU再表示)  1

RAM容量MBを選択してください
1) 1024
2) 2048
3) 4096
メニュー番号を選択してください (0:終了 RET:MENU再表示)  1

NICのリンク速度(Mbps)を選択してください
1) 10
2) 100
3) 1000
メニュー番号を選択してください (0:終了 RET:MENU再表示)  2

OSを選択してください
1) CENTOS_6_64
2) CENTOS_7_64
3) UBUNTU_14_64
4) DEBIAN_8_64
メニュー番号を選択してください (0:終了 RET:MENU再表示)  3

SSH KEY を選択してください

1) login-key
2) takara3
3) chefkey
メニュー番号を選択してください (0:終了 RET:MENU再表示)  3

= VSI CONFIG ==============================
DATACENTER :  tok02
DOMAINNAME :  takara.org
HOSTNAME :    www01
CPU Cores :   1
RAM :         1024 MB
Link Speed :  100 Mbps
OS :          UBUNTU_14_64
Script URL:   https://raw.githubusercontent.com/takara9/ProvisioningScript/master/ubuntu_basic_config
SSH-KEY ID:   370981
===========================================
メニュー番号を選択してください (0:終了 RET:MENU再表示)  

```

## 仮想サーバーのオーダー

VSIのオーダーは 8) vsi_create で実行します。以下に例を提示します。
仮想サーバーのインスタンスが起動した後に、SoftLayerのDNSサーバーにホスト名を登録します。
SoftLayerのDNSサーバーにドメインが登録されていないとDNS登録でエラーになるので、予めドメインを登録しておきます。


```
メニュー番号を選択してください (0:終了 RET:MENU再表示)  8

= VSI CONFIG ==============================
DATACENTER :  tok02
DOMAINNAME :  takara.org
HOSTNAME :    www01
CPU Cores :   1
RAM :         1024 MB
Link Speed :  100 Mbps
OS :          UBUNTU_14_64
Script URL:   https://raw.githubusercontent.com/takara9/ProvisioningScript/master/ubuntu_basic_config
SSH-KEY ID:   370981
===========================================
これで良いですか? (y/n) y
ホスト名が存在しないので新規オーダー（作成）
id       13476157                              
created  2015-10-27T17:26:11+09:00             
guid     1db2b49e-ae3e-4843-bc17-9955d755a919  

処理中.........................................
完了
メニュー番号を選択してください (0:終了 RET:MENU再表示)  
```

これで、ソフトレイヤーのDNSサーバーに登録したDNS名でアクセスできます。
外部インターネットからアドレス解決できる様にするには、正式なドメイン名を購入する必要があります。
この例では、ソフトレイヤーの内部だけの利用になります。

```
chef@ChefWs:~/vsi_tools$ ping www01.takara.org
PING www01.takara.org (10.132.253.30) 56(84) bytes of data.
64 bytes from 10.132.253.30: icmp_seq=1 ttl=64 time=0.916 ms
64 bytes from 10.132.253.30: icmp_seq=2 ttl=64 time=0.239 ms
64 bytes from 10.132.253.30: icmp_seq=3 ttl=64 time=0.241 ms
^C
--- www01.takara.org ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2000ms
rtt min/avg/max/mdev = 0.239/0.465/0.916/0.319 ms
chef@ChefWs:~/vsi_tools$ ssh root@www01.takara.org -i ~/key/chefkey
The authenticity of host 'www01.takara.org (10.132.253.30)' can't be established.
ECDSA key fingerprint is ee:bf:29:45:8b:b8:79:09:97:9e:13:aa:5e:22:36:95.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'www01.takara.org,10.132.253.30' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 14.04.3 LTS (GNU/Linux 3.13.0-65-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
Last login: Tue Oct 27 17:31:55 2015 from 10.0.80.185
root@www01:~# 
```


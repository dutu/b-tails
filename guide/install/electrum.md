---
layout: page
title: Electrum Bitcoin Wallet
parent: Applications
grand_parent: Install & Configure
nav_order: 1
---

# Electrum Bitcoin Wallet

Electrum Bitcoin Wallet comes pre-installed on Tails, however it is not the latest version.

Software installed on Tails cannot be permanently upgraded since it is a fixed (read-only) image.

You can run the most recent version of Electrum with Tails by using the AppImage binary available on official Electrum webpage.

The instructions below can be used to add the latest Electrum version.

## Backup your bitcoin wallet

{: .warning }
If a bitcoin wallet was previously used on this B-Tails USB memory stick, make sure it is backed-up safely and the wallet seed is stored securely.  

* Write down your wallet seed words and store them securely off the computer

* Backup your bitcoin wallet file from the B-Tails memory stick.

## Install Electrum Bitcoin Wallet

* Ensure you are connected to a network and the onion icon at the top confirms Tor network is ready


* Using Tor Browser goto https://electrum.org/#download and find the latest version of Electrum.


* Download the `AppImage` and the signature (`.asc`) files:
  ```shell
  $ cd ~/Downloads
  $ torsocks wget https://download.electrum.org/4.3.3/electrum-4.3.3-x86_64.AppImage
  $ torsocks wget https://download.electrum.org/4.3.3/electrum-4.3.3-x86_64.AppImage.asc
  ```


* Download ThomasV's public key and import it:
  ```shell
  $ torsocks wget https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc
  $ gpg --import ThomasV.asc
  ```

* Verify GPG signature of Electrum AppImage:
  ```shell
  $ electrumAppImageFile=$(find electrum*.AppImage | tail -n 1)
  $ echo Using ${electrumAppImageFile}
  $ gpg --verify ${electrumAppImageFile}.asc ${electrumAppImageFile}
  ```
  and wait for confirmation:
  ```shell
  > Good signature from "Thomas Voegtlin (https://electrum.org) <thomasv@electrum.org>
  >  ...
  > Primary key fingerprint: 6694 D8DE 7BE8 EE56 31BE  D950 2BD5 824B 7F94 70E6
  ```

* Download and extract Electrum config files:
  ```shell
  $ torsocks wget https://github.com/dutu/b-tails/raw/main/resources/electrum.zip
  $ 7z x electrum.zip
  $ ls -ls electrum
  ```

* Confirm/edit Electrum `config`
  ```shell
  $ nano electrum/config
  ```
  Default `config` is:
  ```json
  {
      "auto_connect": false,
      "check_updates": false,
      "config_version": 3,
      "decimal_point": 8,
      "fee_level": 3,
      "fiat_address": true,
      "history_rates": true,
      "is_maximized": false,
      "oneserver": true,
      "proxy": "socks5:localhost:9050",
      "qt_gui_color_theme": "dark",
      "server": "g4ishflgsssw5diuklqsgdb5ppsz5t2sxevysqtfpj27o5xnjbzit4qd.onion:50002:s",
      "show_addresses_tab": true,
      "show_channels_tab": true,
      "use_exchange": "Kraken",
      "use_exchange_rate": true
  }
  ```
  
  {: .important }
  > Pay attention to following default values:
    * `"proxy": "socks5:localhost:9050"` -> use Tor network. It should not be changed.
    * `"server"` -> default value is a secure Electrum server. You can replace it with your own Electrum server address, or you can remove it entirely to connect to a random Electrum server. If removed, the parameter `oneserver` should also be removed.
    * `"oneserver": true`  -> connect to one Electrum server only, that is the server specified with parameter `server`.
    * `"auto_connect": false` -> stick with current server even if it is lagging. When changed to `true`, every time the Electrum client receives a block header from any server, it checks if the current server is lagging, and if so, it switches to one that has the best block. "lagging" is defined to be missing at least two blocks. 


* Confirm/edit Electrum startup options:
  ```shell
  $ nano electrum/start_electrum.sh
  ```
  Default startup file is:
  ```shell
  #!/bin/bash
  
  persistence_dir=/live/persistence/TailsData_unlocked
  electrum_AppImage=$(find ${persistence_dir}/electrum/*.AppImage | tail -n 1)
  ${electrum_AppImage} --forgetconfig
  ```
  
  {: .important }
  > `--forgetconfig` option is specified. It indicates that Electrum should not remember any configuration settings when launched again. If `--forgetconfig` is removed, any configuration changes are saved, including the name and path of the last wallet used. If this is a privacy concern, do not remove the parameter!    


* Copy config files to Permanent storage:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ rm -fr ${persistence_dir}/electrum/*
  $ cp ${electrumAppImageFile} ${persistence_dir}/electrum
  $ chmod +x ${persistence_dir}/electrum/${electrumAppImageFile}
  $ cp electrum/electrum_logo.png ${persistence_dir}/electrum
  $ cp electrum/config ${persistence_dir}/electrum
  $ cp electrum/start_electrum.sh ${persistence_dir}/electrum
  $ mkdir -p $persistence_dir/dotfiles/.local/share/applications
  $ cp electrum/electrum.desktop $persistence_dir/dotfiles/.local/share/applications
  ```

* Set udev rules to support Ledger devices:
  ```shell
  $ torsocks wget https://github.com/LedgerHQ/udev-rules/raw/master/add_udev_rules.sh
  $ sudo bash add_udev_rules.sh
  ```

* Restart Tails and unlock the Persistent Storage


* You can now start the latest Electrum Bitcoin Wallet 
  * Choose **Applications ▸ Other ▸ Electrum Bitcoin Wallet**

---
Next: [Tails Autostart >>](tails_autostart.html)
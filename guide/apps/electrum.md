---
layout: page
title: Electrum Bitcoin Wallet
parent: Applications
nav_order: 20
---

## Electrum Bitcoin Wallet
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}


---
### Overview

[Electrum](https://electrum.org/){:target="_blank" rel="noopener"} is an open-source, secure, versatile Bitcoin wallet, known for its speed and simplicity. 

Electrum Bitcoin Wallet comes pre-installed on Tails, however it is not the latest version. This guide can be used to add the latest Electrum version.

---
### Install the latest version of Electrum

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Check latest VeraCrypt release:
  ```shell
  $ VERSION=$(wget -qO- https://api.github.com/repos/spesmilo/electrum/tags | grep -Po '"name": "\K.*?(?=")' | grep -P '^\d+\.\d+\.\d+$' | sort -V | tail -n 1)
  $ echo $VERSION
  ```

  > You can also confirm it by checking the official Electrum download page at [https://electrum.org/](https://electrum.org/#download){:target="_blank" rel="noopener"}


* Download latest `AppImage` and signature (`.asc`):
  ```shell
  $ cd ~/Downloads
  $ wget https://download.electrum.org/$VERSION/electrum-$VERSION-x86_64.AppImage
  $ wget https://download.electrum.org/$VERSION/electrum-$VERSION-x86_64.AppImage.asc
  ```


* Download Electrum archive and signature (`.asc`):
  ```shell
  $ wget https://download.electrum.org/$VERSION/Electrum-$VERSION.tar.gz
  $ wget https://download.electrum.org/$VERSION/Electrum-$VERSION.tar.gz.asc
  ```


* Import ThomasV's public key and confirm the result:
  ```shell
  $ wget https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc
  $ gpg --import ThomasV.asc
  > gpg: key 0x2BD5824B7F9470E6: public key "Thomas Voegtlin (https://electrum.org) <thomasv@electrum.org>" imported
  > gpg: Total number processed: 1
  > gpg:               imported: 1
  ```


* Verify GPG signature of Electrum AppImage:
  ```shell
  $ gpg --verify electrum-$VERSION-x86_64.AppImage.asc electrum-$VERSION-x86_64.AppImage
  > Good signature from "Thomas Voegtlin (https://electrum.org) <thomasv@electrum.org>
  > ...
  > Primary key fingerprint: 6694 D8DE 7BE8 EE56 31BE  D950 2BD5 824B 7F94 70E6
  ```


* Verify GPG signature of Electrum archive:
  ```shell
  $ gpg --verify Electrum-$VERSION.tar.gz.asc Electrum-$VERSION.tar.gz
  > Good signature from "Thomas Voegtlin (https://electrum.org) <thomasv@electrum.org>
  > ...
  > Primary key fingerprint: 6694 D8DE 7BE8 EE56 31BE  D950 2BD5 824B 7F94 70E6
  ```


* Create persistent application directory:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ sudo mkdir -p $persistence_dir/electrum
  $ sudo chown -R amnesia:amnesia $persistence_dir/electrum
  $ chmod 700 $persistence_dir/electrum
  ```


* Copy the application file, and make it executable:
  ```shell
  $ rm -f $persistence_dir/electrum/*.AppImage
  $ cp electrum-$VERSION-x86_64.AppImage $persistence_dir/electrum
  $ chmod +x $persistence_dir/electrum/electrum-$VERSION-x86_64.AppImage
  ```


* Extract and copy udev rules needed for the HW wallet devices:
  ```shell
  $ tar -xzvf Electrum-$VERSION.tar.gz
  $ rm -fr $persistence_dir/electrum/udev
  $ rsync -av Electrum-$VERSION/contrib/udev/ $persistence_dir/electrum/udev/
  ```


* Download and extract Electrum asset files:
  ```shell
  $ wget https://raw.githubusercontent.com/dutu/b-tails/master/resources/electrum-assets.tar.gz
  $ tar -xzvf electrum-assets.tar.gz
  ```


* Change the new default `config` file, if needed:
  ```shell
  $ nano electrum-assets/config
  ```
  New default `config` is:
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

  > * `"server"` -> default value is a secure Electrum server. You can replace it with your own Electrum server address, or you can remove it entirely to connect to a random Electrum server. If removed, the parameter `oneserver` should also be removed.
  > * `"oneserver": true`  -> connect to one Electrum server only (which is the server specified with parameter `server`).
  > * `"auto_connect": false` -> stick with current server even if it is lagging. When changed to `true`, every time the Electrum client receives a block header from any server, it checks if the current server is lagging, and if so, it switches to one that has the best block. "lagging" is defined to be missing at least two blocks.

  {: .important }
  > If you are upgrading Electrum, you may want to check the existing settings
  > ```shell
  > $ cat $persistence_dir/electrum/config
  > ```
  >  and add them to the new `config` file.


* Copy Electrum config and script files to persistent application directory:
  > The following files are copied to Electrum persistent directory `$persistence_dir/electrum`:
  > * `config` - Persistent electrum configuration that has been reviewed at previous step.
  > * `electrum_start.sh` - This script starts Electrum application. It first checks if udev rules needed for the HW wallet devices have been applied, and if not applies them.
  > 
  > Please inspect the files carefully to ensure they don't contain any harmful content.

  ```shell
  $ rsync -av electrum-assets/ $persistence_dir/electrum/
  ```


* Make scrips executable:
  ```shell
  $ chmod +x $persistence_dir/electrum/electrum_start.sh
  ```


* Copy application .desktop file to persistent local directory, which serves as a menu item:
  ```shell
  $ persistent_desktop_file=$persistence_dir/dotfiles/.local/share/applications/Electrum.desktop
  $ mkdir -p $persistence_dir/dotfiles/.local/share/applications
  $ cp Electrum-$VERSION/electrum.desktop $persistent_desktop_file
  ```


* Update `Icon` entry of the .desktop file to point to Electrum icon file:
  ```shell
  $ cp Electrum-$VERSION/electrum/gui/icons/electrum.png $persistence_dir/electrum/
  $ desktop-file-edit --set-icon="$persistence_dir/electrum/electrum.png" $persistent_desktop_file
  ```


* Update `Exec` entry of the .desktop file to run `electrum_start.sh` instead of starting electrum directly:
  ```shell
  $ sed -i 's|Exec=\(electrum.*\)|Exec=/bin/bash -c "$persistence_dir/electrum/electrum_start.sh \1"|' $persistent_desktop_file
  ```


* Make the menu item visible: 
  ```shell
  ln -s $persistence_dir/dotfiles/.local/share/applications/Electrum.desktop /home/amnesia/.local/share/applications
  ```

---
### Start Electrum

* Choose **Applications ▸ Other ▸ Electrum**.

---
### For the Future: Update Electrum

* Follow the steps in section [Install the latest version of Electrum](#install-the-latest-version-of-electrum).

---
### Remove installation of latest version of Electrum

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Remove the application:
  ```shell
  persistence_dir=/live/persistence/TailsData_unlocked
  sudo rm -fr $persistence_dir/electrum
  ```


* Remove Electrum menu item from the desktop menu:
  ```shell
  rm $persistence_dir/dotfiles/.local/share/applications/Electrum.desktop
  ```
--- 

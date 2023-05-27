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

{: .important }
> Electrum's persistent storage is set at `/live/persistence/TailsData_unlocked/electrum`.
>
> We link the default `wallets` directory to this storage, independent of the "Electrum Bitcoin Wallet" feature's status in Persistent Storage.<br>
> If this feature is ON, Electrum uses the `config` file, preserving configuration changes between reboots.<br>
> If it's OFF, the `config.default` file is used and configuration changes are reset post-reboot.


* Make sure **Tails Autostart** utility has been installed. See [Tails Autostart](/guide/utils/tails_autostart.html).


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


* Download and extract utility files:
  ```shell
  $ wget https://raw.githubusercontent.com/dutu/b-tails/master/utils/electrum-utils.tar.gz
  $ tar -xzvf electrum-utils.tar.gz
  ```


* Change the new default `config.default` file, if needed:
  ```shell
  $ nano electrum-utils/config.default
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

  > * `"server"` -> default value is a secure and privacy focused Electrum server. You can replace it with your own Electrum server address, or you can remove it entirely to connect to a random Electrum server. If removed, the parameter `oneserver` should also be removed.
  > * `"oneserver": true`  -> connect to one Electrum server only (which is the server specified with parameter `server`).
  > * `"auto_connect": false` -> stick with current server even if it is lagging. When changed to `true`, every time the Electrum client receives a block header from any server, it checks if the current server is lagging, and if so, it switches to one that has the best block. "lagging" is defined to be missing at least two blocks.

  {: .important }
  > If you are upgrading Electrum, you may want to update the file checking existing `config` and `config.default` at `/live/persistence/TailsData_unlocked/electrum`: 
  > ```shell
  > $ cat /live/persistence/TailsData_unlocked/electrum/config
  > $ cat /live/persistence/TailsData_unlocked/electrum/config.default
  > ```


* Copy `default.config` and script files to persistent storage:
  > The following files are copied to persistent storage:
  > * `config.default` - default configuration that has been reviewed at previous step.
  > * `electrum-config-setup.sh` - script to connect `wallets` directory to persistent storage and to make Electrum use persistent `config` or default `config.default`. 
  > * `electrum-start.sh` - script to start Electrum application. It first checks if udev rules needed for the HW wallet devices have been applied, and if not applies them.
  > 
  > Please inspect the files carefully to ensure they don't contain any harmful content.

  ```shell
  $ cp electrum-utils/config.default $persistence_dir/electrum
  $ rm -fr $persistence_dir/electrum/utils
  $ rsync -av electrum-utils/ $persistence_dir/electrum/utils
  ```


* Make scrips executable:
  ```shell
  $ chmod +x $persistence_dir/electrum/utils/electrum-start.sh
  $ chmod +x $persistence_dir/electrum/utils/electrum-config-setup.sh
  ```


* Execute `electrum-config-setup.sh` to set up Electrum configuration, and make it autostart:
  ```shell
  $ $persistence_dir/electrum/utils/electrum-config-setup.sh
  $ cp $persistence_dir/electrum/utils/electrum-config-setup.sh $persistence_dir/dotfiles/.config/autostart/amnesia.d/
  ```


* Copy application .desktop file to persistent local directory, which serves as a desktop menu item:
  ```shell
  $ persistent_desktop_file=$persistence_dir/dotfiles/.local/share/applications/electrum.desktop
  $ mkdir -p $persistence_dir/dotfiles/.local/share/applications
  $ cp Electrum-$VERSION/electrum.desktop $persistent_desktop_file
  ```


* Update `Icon` entry of the .desktop file to point to Electrum icon file:
  ```shell
  $ cp Electrum-$VERSION/electrum/gui/icons/electrum.png $persistence_dir/electrum/
  $ desktop-file-edit --set-icon="$persistence_dir/electrum/electrum.png" $persistent_desktop_file
  ```


* Update `Exec` entry of the .desktop file to run `electrum_start.sh`:
  ```shell
  $ sed -i "s|Exec=electrum \(.*\)|Exec=$persistence_dir/electrum/utils/electrum-start.sh \1|" $persistent_desktop_file
  ```


* Make the menu item visible in **Applications ▸ Other**:
  ```shell
  $ desktop-file-edit --remove-category="Network" $persistent_desktop_file 
  $ ln -s $persistence_dir/dotfiles/.local/share/applications/electrum.desktop /home/amnesia/.local/share/applications
  ```

---
### Start Electrum

> Electrum's persistent storage is set at `/live/persistence/TailsData_unlocked/electrum`.
>
> Default `wallets` directory is linked to this storage, independent of the "Electrum Bitcoin Wallet" feature's status in Persistent Storage.<br>
> If this feature is ON, Electrum uses the `config` file, preserving configuration changes between reboots.<br>
> If it's OFF, the `config.default` file is used and configuration changes are reset post-reboot.

> Electrum config includes reference to the last wallet used.<br>
> If, for privacy, you don't want Electrum to show after this file as recently open after reboot, turn off "Electrum Bitcoin Wallet" feature in Persistent Storage.  


* Choose **Applications ▸ Other ▸ Electrum**.

---
### For the Future: Update Electrum

* Follow the steps in section [Install the latest version of Electrum](#install-the-latest-version-of-electrum).

---
### Remove installation of latest version of Electrum

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Remove the application and util files:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ rm -f $persistence_dir/electrum/*.AppImage
  $ rm -f $persistence_dir/electrum/config.default
  $ rm -fr $persistence_dir/electrum/utils
  $ rm -fr $persistence_dir/electrum/udev
  ```


* Remove autostart script:
  ```shell
  $ rm -f $persistence_dir/dotfiles/.config/autostart/amnesia.d/electrum-config-setup.sh
  ```

  
* Remove the files for the menu item:
  ```shell
  $ rm -f $persistence_dir/dotfiles/.local/share/applications/electrum.desktop
  $ rm -f /home/amnesia/.local/share/applications/electrum.desktop
  $ rm -f $persistence_dir/electrum/electrum.png
  ```

  
* Remove `~/.electrum/wallets`, if it is a symbolic link to directory to persistent storage:
  ```shell
  $ [ -h ~/.electrum/wallets ] && rm ~/.electrum/wallets || echo "~/.electrum/wallets is not a symlink"
  ```


* Remove `~/.electrum/config` if it's not the same file as `$persistence_dir/electrum/config` 
  ```shell
  [ ~/.electrum/config -ef $persistence_dir/electrum/config ] || rm ~/.electrum/config
  ```
--- 

---
layout: page
title: Electrum Bitcoin Wallet
parent: Applications
grand_parent: Install & Configure
nav_order: 1
---

# Electrum Bitcoin Wallet

Electrum Bitcoin Wallet comes pre-installed on Tails, however it is not the latest version.
To run the most recent version of Electrum, the instructions below can be used. 

## Install Electrum Bitcoin Wallet

* Ensure you are connected to a network and the onion icon at the top confirms Tor network is ready


* Using Tor Browser goto https://electrum.org/#download and find the latest version of Electrum


* Download the `AppImage` and the signature (`.asc`) files:
  ```shell
  $ cd ~/Downloads
  $ wget https://download.electrum.org/4.3.3/electrum-4.3.3-x86_64.AppImage
  $ wget https://download.electrum.org/4.3.3/electrum-4.3.3-x86_64.AppImage.asc
  ```


* Download ThomasV's public key and import it:
  ```shell
  $ wget https://raw.githubusercontent.com/spesmilo/electrum/master/pubkeys/ThomasV.asc
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

* Copy files to Permanent storage:
  ```shell
  $ rm -f ${persistance_dir}/electrum/*
  $ cp ${electrumAppImageFile} ${persistence_dir}/electrum
  $ chmod +x ${persistence_dir}/electrum/${electrumAppImageFile}
  $ cp /home/amnesia/Downloads/setup_tails/install_electrum/electrum_logo.png ${persistence_dir}/electrum
  $ cp /home/amnesia/Downloads/setup_tails/install_electrum/config ${persistence_dir}/electrum
  $ electrum=$(find ${persistence_dir}/electrum/*.AppImage | tail -n 1)
  ```

* Set udev rules to support Ledger devices:
  ```shell
  wget https://github.com/LedgerHQ/udev-rules/raw/master/add_udev_rules.sh
  sudo bash add_udev_rules.sh
  ```


---
Next: [Tails Autostart >>](tails_autostart.html)
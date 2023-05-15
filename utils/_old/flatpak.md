---
layout: page
title: Flatpak
parent: Utils
nav_order: 20
---

## Flatpak
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
### Overview

[Flatpak](https://www.flatpak.org/){:target="_blank" rel="noopener"} is an open-source software utility that provides a sandboxed environment for distributing and running Linux applications.


---
### Install Flatpak

* Make sure **Tails Autostart** utility has been installed. See [Tails Autostart](/guide/utils/tails_autostart.html).


* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Install flatpak software package:
  ```shell
  $ sudo apt update
  $ sudo apt install flatpak
  ```
    * Click **Install Every Time**, when Tails asks if you want to add flatpak to your additional software


* Download and extract the script help files:
  ```shell
  $ cd ~/Downloads
  $ wget https://raw.githubusercontent.com/dutu/b-tails/master/resources/flatpak-assets.tar.gz
  $ tar -xzvf flatpak-assets.tar.gz
  ```


* Create persistent directory for flatpak software packages:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ sudo mkdir -p $persistence_dir/flatpak
  $ sudo chown -R amnesia:amnesia $persistence_dir/flatpak
  $ chmod 700 $persistence_dir/flatpak 
  ```


* Execute the scripts to set-up persistent Flatpak apps: 
  ```shell
  $ chmod +x flatpak-assets/flatpak-setup-persistent-apps.sh
  $ ./flatpak-assets/flatpak-setup-persistent-apps.sh
  ```


* Make the scripts autostart on Tails startup:
  ```shell
  $ rsync -a flatpak-assets/flatpak-*.sh $persistence_dir/dotfiles/.config/autostart/amnesia.d/
  ```

* Add the Flathub repository
  ```shell
  torsocks flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  ```
  
---

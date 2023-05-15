---
layout: page
title: Tails Autostart
parent: Utils
nav_order: 10
---

## Tails Autostart
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
### Overview

[Tails Autostart](https://github.com/dutu/tails-autostart){:target="_blank" rel="noopener"} is a utility script that automatically starts scripts/applications on Tails bootup.

This facilitates other applications to work properly.


---
### Install Tails Autostart

* Boot on Tails, from the Welcome Screen set-up administration password and unlock the Persistent Storage.


* Connect to internet.


* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Download and unpack Tails-autostart files:
  ```shell
  $ cd ~/Downloads
  $ wget https://raw.githubusercontent.com/dutu/tails-autostart/master/assets/tails-autostart.tar.gz
  $ tar -xzvf tails-autostart.tar.gz
  ```

* Run installation script:
  ```shell
  $ cd tails-autostart
  $ chmod +x install_tails_autostart.sh
  $ sudo ./install_tails_autostart.sh
  ```

---
### How to use it

* add any scripts to `/live/persistence/TailsData_unlocked/dotfiles/.config/autostart/amnesia.d` to execute them on startup as amnesia
* add any scripts to `/live/persistence/TailsData_unlocked/dotfiles/.config/autostart/root.d to` execute them on startup as root


---
### For the future: Update Tails Autostart

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Check installed version:
  ```shell
  version_file=$(find "/live/persistence/TailsData_unlocked/tails-autostart" -maxdepth 1 -type f -name "version*.txt" | head -n 1)
  echo "${version_file}" | grep -oP 'version-\K.*(?=\.txt)'
  ```
  

* Check the latest Tails Autostart release:
  ```shell
  wget -qO- https://api.github.com/repos/joinmarket-webui/jam/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'
  ```


* Perform all steps in section [Uninstall Tails Autostart](#uninstall-tails-autostart)


* Perform all steps in section [Install Tails Autostart](#install-tails-autostart) 


---
### Uninstall Tails Autostart

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Remove Tails Autostart files:
  ```shell
  $ rm /live/persistence/TailsData_unlocked/dotfiles/.config/autostart/Tails-autostart.desktop
  $ find /live/persistence/TailsData_unlocked/dotfiles/.config/autostart/ -type f -name "*.example" -exec rm -f {} +
  $ sudo rm -rf /live/persistence/TailsData_unlocked/tails-autostart
  ```


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


* Create persistent directory for flatpak software packages:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ sudo mkdir -p $persistence_dir/flatpak
  $ sudo chown -R amnesia:amnesia $persistence_dir/flatpak
  $ chmod 700 $persistence_dir/flatpak 
  ```


* Download and extract utility files:
  ```shell
  $ cd ~/Downloads
  $ wget https://raw.githubusercontent.com/dutu/b-tails/master/utils/flatpak-utils.tar.gz
  $ tar -xzvf flatpak-utils.tar.gz
  ```


* Copy utility files to persistent storage and make scripts executable:
  ```shell
  $ rsync -av flatpak-utils/ $persistence_dir/flatpak/utils/
  $ find $persistence_dir/flatpak/utils -type f -name "*.sh" -exec chmod +x {} \;
  ```


* Execute the scripts to set-up persistent Flatpak apps and make it autostart: 
  ```shell
  $ $persistence_dir/flatpak/utils/flatpak-setup-persistent-apps.sh
  $ rsync -a $persistence_dir/flatpak/utils/flatpak-setup-persistent-apps.sh $persistence_dir/dotfiles/.config/autostart/amnesia.d/
  ```


* Add flatpak remote:
  ```shell
  $ torsocks flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  ```

{: .highlight }

> Flatpak is now installed applications can be added with `flatpak install`.
> 
> You can launch your Flatpak application from the GNOME desktop using a menu item, which is represented by a .desktop file.
>
> While `flatpak install` does generate a .desktop file, its location, along with the Icon and Exec fields, must be adjusted to ensure compatibility with Tails OS. This necessity stems from:
>   * The unique architecture of Tails OS: It doesn't define the `XDG_DATA_DIRS` environment variable, causing the Flatpak share directory (where the .desktop and icon files reside) to be omitted from the GNOME search path.
>   * Tails OS's practice of reinstalling additional software packages after each reboot, which takes a few minutes: This process inhibits the GNOME desktop from locating the `flatpak run` (command specified in the .desktop file) post-reboot, resulting in the .desktop file being overlooked.
>
> By relocating the .desktop file to the appropriate directory and adjusting the Icon and Exec entries, the system will be able to display the correct menu item to launch your application.
>
> We've developed three utilities to simplify these tasks:
>
> * `flatpak-menu-item-copy.sh` identifies the application's .desktop file and copies it to the right location in persistent storage.<br>
    The source .desktop file is first searched for in the persistent application directory and, if not found, in the Flatpak shared directory.
> * `flatpak-menu-item-update-icon.sh` finds the application's icon file and updates the Icon entry with its path.<br>
    The icon file is primarily searched for in the persistent application directory and, if not found, in the Flatpak shared directory.
> * `flatpak-menu-item-update-exec.sh` seeks to update the Exec entry to point to `flatpak-run.sh`.<br>
     This script creates the `flatpak-run.sh` script that launches the application based on the original .desktop file's Exec entry.


---

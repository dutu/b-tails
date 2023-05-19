---
layout: page
title: Telegram Desktop Messenger
parent: Applications
nav_order: 40
---

## Telegram Desktop Messenger
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
### Overview

[Signal](https://signal.org/){:target="_blank" rel="noopener"} is a privacy-focused messaging application that offers end-to-end encryption for secure text messages, voice calls, and video calls.


![signal.png](/images/signal.png)

{: .highlight }
For privacy reasons, the application is set-up so that the configuration is not persistent; it is cleared when Tails reboots. This means every time after a reboot, you'd need to link Signal to your account. It is possible to set-up a persistent configuration, but this is not described here.

---
### Install Signal

* Make sure **Flatpak** has been installed. See [Flatpak](/guide/utils/flatpak.html).


* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Add a flatpak remote and install Telegram:
  ```shell
  $ torsocks flatpak install flathub org.telegram.desktop
  ```
  > This may take 30-45 minutes, depending on TOR connection speed


* Create persistent Telegram application directory:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ app_id=org.telegram.desktop
  $ sudo mkdir -p $persistence_dir/$app_id
  $ sudo chown -R amnesia:amnesia $persistence_dir/$app_id
  $ chmod 700 $persistence_dir/$app_id 
  ```

> You can launch your Flatpak application from the GNOME desktop using a menu item, which is represented by a .desktop file.
>
> While `flatpak install` does generate a .desktop file, its location, along with the Icon and Exec fields, must be adjusted to ensure compatibility with Tails OS. This necessity stems from:
>   * The unique architecture of Tails OS: It doesn't define the `XDG_DATA_DIRS` environment variable, causing the Flatpak share directory (where the .desktop and icon files reside) to be omitted from the GNOME search path.
>   * Tails OS's practice of reinstalling additional software packages after each reboot: This process inhibits the GNOME desktop from locating the `flatpak run` command specified in the Exec field post-reboot, resulting in the .desktop file being overlooked.
> 
> By relocating the .desktop file to the appropriate directory and adjusting the Icon and Exec entries, the system will be able to display the correct menu item to launch your application. 
> 
> We've developed three utilities to simplify these tasks:
> 
> * `flatpak-copy-app-menu-item.sh` identifies the application's .desktop file and copies it to the right location in persistent storage.<br> 
>    The source .desktop file is first searched for in the persistent application directory and, if not found, in the Flatpak shared directory.
> * `flatpak-update-menu-item-icon.sh` finds the application's icon file and updates the Icon entry with its path.<br> 
>   The icon file is primarily searched for in the persistent application directory and, if not found, in the Flatpak shared directory.
> * `flatpak-update-menu-item-exec.sh` seeks to update the Exec entry to point to `start-$app_id.sh`.<br> 
>   This script tries to locate `start-$app_id.sh` in the persistent application directory. If the file doesn't exist, it's created based on the original .desktop file's Exec entry.


* Copy application .desktop file to persistent local directory, which serves as a menu item:
  ```shell
  $ $persistence_dir/flatpak/utils/flatpak-copy-app-menu-item.sh $app_id
  ```

* Update Icon entry of the .desktop file:
  ```shell
  $ $persistence_dir/flatpak/utils/flatpak-update-menu-item-icon.sh $app_id
  ```

* Update Exec entry of the .desktop file:
  ```shell
  $ $persistence_dir/flatpak/utils/flatpak-update-menu-item-icon.sh $app_id
  ```


* To start Signal choose **Applications ▸ Other ▸ Signal**


---

### Update Signal

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Update the application:
  ```shell
  torsocks flatpak update flathub org.signal.Signal
  ```
  
---

### Remove Signal

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Remove the application:
  ```shell
  torsocks flatpak uninstall flathub org.signal.Signal
  ```


* Remove unused runtimes and SDK extensions:
  ```shell
  torsocks flatpak uninstall --unused
  ```
  

* Remove Signal menu item from the desktop menu:
  ```shell
  rm $persistence_dir/dotfiles/.local/share/applications/signal.desktop
  ```

* Remove Signal asset files:
  ```shell
  rm -fr $persistence_dir/signal
  ```

--- 

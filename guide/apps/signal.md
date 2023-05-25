---
layout: page
title: Signal Desktop Messenger
parent: Applications
nav_order: 30
---

## Signal Desktop Messenger
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
For privacy, the application's configuration is not persistent and resets with every Tails reboot.<br>
As a result, after each reboot you link Signal to your account.<br>
Although possible, the process for setting up a persistent configuration isn't covered in this instruction.


---
### Install Signal

* Make sure **Flatpak** has been installed. See [Flatpak](/guide/utils/flatpak.html).


* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Install signal:
  ```shell
  $ app_id="org.signal.Signal"
  $ torsocks flatpak install flathub $app_id
  ```


* Create persistent Signal application directory:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ sudo mkdir -p $persistence_dir/$app_id
  $ sudo chown -R amnesia:amnesia $persistence_dir/$app_id
  $ chmod 700 $persistence_dir/$app_id 
  ```

---
### Create desktop menu item and update settings

* Copy application .desktop file to persistent local directory, which serves as a menu item:
  ```shell
  $ $persistence_dir/flatpak/utils/flatpak-menu-item-copy.sh $app_id
  ```


* Update `Icon` entry of the .desktop file:
  ```shell
  $ $persistence_dir/flatpak/utils/flatpak-menu-item-update-icon.sh $app_id
  ```


* Update `Exec` entry of the .desktop file:
  ```shell
  $ $persistence_dir/flatpak/utils/flatpak-menu-item-update-exec.sh $app_id
  ```


* Update .desktop file for compatibility with Tails OS:
  ```shell
  $ persistent_desktop_file="$persistence_dir/dotfiles/.local/share/applications/$app_id.desktop"
  $ desktop-file-edit --remove-key="SingleMainWindow" $persistent_desktop_file
  $ desktop-file-edit --remove-category="Network" $persistent_desktop_file 
  ```


* Force GNOME to recognize a change in the .desktop file to display the menu item:
  ```shell
  $ local_desktop_dir="/home/amnesia/.local/share/applications"
  $ mv "$local_desktop_dir/$app_id.desktop" "$local_desktop_dir/$app_id.temp.desktop"
  $ mv "$local_desktop_dir/$app_id.temp.desktop" "$local_desktop_dir/$app_id.desktop"
  ```

* Set proxy server for application to work on Tails:
   ```shell
   $ nano $persistence_dir/$app_id/flatpak-run.sh
   ```

   Insert pre-launch configuration: 
   ```shell
   ### START: Insert pre-launch commands or configurations here.
   ### For instance, to set up a proxy server or perform any pre-launch configurations.
   export HTTP_PROXY=socks://127.0.0.1:9050
   export HTTPS_PROXY=socks://127.0.0.1:9050
   ### END: Pre-launch customization.
   ```
  
  Save the file and exit the text editor. 

---
### Start Signal

* Choose **Applications ▸ Other ▸ Signal**

---
### For the Future: Update Signal

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Update the application:
  ```shell
  $ torsocks flatpak update org.signal.Signal
  ```

---
### Remove Signal

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Remove the application:
  ```shell
  $ torsocks flatpak uninstall org.signal.Signal
  ```


* Remove unused runtimes and SDK extensions:
  ```shell
  $ torsocks flatpak uninstall --unused
  ```


* Remove .desktop files representing the menu item:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ rm $persistence_dir/dotfiles/.local/share/applications/org.signal.Signal
  $ rm /home/amnesia/.local/share/applications/org.signal.Signal
  ```


* Remove Signal utils files:
  ```shell
  $ sudo rm -fr $persistence_dir/org.signal.Signal
  ```

--- 

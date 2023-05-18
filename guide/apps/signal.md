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
For privacy reasons, the application is set-up so that the configuration is not persistent; it is cleared when Tails reboots. This means every time after a reboot, you'd need to link Signal to your account. It is possible to set-up a persistent configuration, but this is not described here.

---
### Install Signal

* Make sure **Flatpak** has been installed. See [Flatpak](/guide/utils/flatpak.html).


* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Install signal:
  ```shell
  $ torsocks flatpak install flathub org.signal.Signal
  ```
  > This may take 30-45 minutes, depending on TOR connection speed


* Download and extract Signal asset files:
  ```shell
  $ cd ~/Downloads
  $ wget https://raw.githubusercontent.com/dutu/b-tails/master/resources/signal-assets.tar.gz
  $ tar -xzvf signal-assets.tar.gz
  ```


* Execute the script to generate the file for desktop menu item:
  ```shell
  $ chmod +x signal-assets/generate_desktop_file.sh
  $ sudo ./signal-assets/generate_desktop_file.sh
  ```
  > This script generates a .desktop file that enables GNOME to display the menu item. This starts signal with a custom start-up script (`start_org.signal.Signal.sh`), which sets the proxy before launching the application.


* Copy the start-up script files to app directory:
  ```shell
  $ chmod +x signal-assets/start_org.signal.Signal.sh
  $ rsync -a signal-assets/start_org.signal.Signal.sh $persistence_dir/org.signal.Signal/
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

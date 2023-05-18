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
  $ torsocks flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  $ torsocks flatpak install flathub org.telegram.desktop
  ```
  > This may take 30-45 minutes, depending on TOR connection speed


* Create persistent Telegram menu item in the desktop menu:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ ln -s $persistence_dir/dotfiles/.local/share/applications/org.telegram.desktop.desktop $persistence_dir/flatpak/exports/share/applications/org.telegram.desktop.desktop
  ```

> The menu item will be visible after Tails reboot.

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

---
layout: page
title: Signal Desktop Messenger
parent: Applications
grand_parent: Install & Configure
nav_order: 4
---

# Signal Desktop Messenger

{: .important }
For privacy reasons, the application is setup so that the configuration is not persistent; it is cleared when Tails reboots. This means the Signal account would need every time when Signal is used after Tails reboot. It is also possible to configure a persistent configuration, but this is not described here.


## Install Signal

* Make sure **Tails Autostart** utility has been installed. See [Tails Utilities](tails_utilities.html#tails-autostart).

* Install flatpak:
  ```shell
  $ sudo apt install flatpak
  ```

    * Tails then asks if you want to add flatpak to your additional software, and you should do so.

* Download and extract Signal config files:
  ```shell
  $ cd ~/Downloads
  $ torsocks wget https://github.com/dutu/b-tails/raw/main/resources/signal.zip
  $ 7z x signal.zip
  $ ls -ls signal
  ```

* Setup persistent directory for flatpak software packages and make it autostart on Tails startup 
  ```shell
  signal/setup-flatpak-persistent-apps.sh
  cp signal/setup-flatpak-persistent-apps.sh /live/persistence/TailsData_unlocked/dotfiles/.config/autostart/amnesia.d
  ```

* Add a flatpak remote and install signal:
  ```shell
  $ torsocks flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  $ torsocks flatpak install flathub org.signal.Signal
  ```
  > This may take 30-45 minutes, depending on TOR connection speed


* Add a Signal app icon on Gnome **Applications ▸ Other ▸ Signal**:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ mkdir -p $persistence_dir/dotfiles/.local/share/applications
  $ cp signal/signal.desktop $persistence_dir/dotfiles/.local/share/applications
  $ mkdir -p $persistence_dir/signal
  $ cp signal/start_signal.sh $persistence_dir/signal
  ```
  > The app icon will be visible after next Tails reboot

---
---
layout: page
title: Partitions
parent: System Preparation
nav_order: 20
has_toc: false
---

## Partitions
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
### Overview

We partition the USB memory stick to have the following structure:

![](../../images/disk_layout.png)

1. `TAILS` - partition where Tails is installed.
2. `README` - 512MB exFAT partition - unencrypted partition, can be used to store insensitive data.
3. `VeraCrypt` - 4GB exFAT partition - encrypted with VeraCrypt, should be used to store private files.
4. `TailsData` - encrypted Tails Persistent Storage, used for some persistent Tails OS settings and additional software, can also be used to store private files.


{: .highlight }

> The size of the Partitions 2-4 can be adjusted when created. Values above are proposed settings.

---
### Create partitions

* Boot to Tails from the USB stick. After one or to minutes **Welcome to Tails!** screen appears.
 
  ![](../../images/welcome_screen.png)


* Set admin password:
    * Click **+** under **Additional Settings**
    * Click **Administration Password**
    * enter a password and confirm it
    * click **Add**


* Start Tails:
    * Click **Start Tails**


* Start **Disks** application:
    * Choose **Applications ▸ Utilities ▸ Disks**


* Select the USB flash drive on the left panel.


* Create the `README` partition:
    * Click **Free Space**, then **+**, set **Partition Size** to `512 MB`, click **Next**
    * Set **Volume Name** to `README`, select **Other**, click **Next**
    * Select **exFAT** and, finally, click **Create**


* Create `VeraCrypt` partition:
    * Click **Free Space**, then **+**, set **Partition Size** to `2048 MB`, click **Next**
    * Set **Volume Name** to `VeraCrypt`, select **Other**, click **Next**
    * Select **exFAT** and, finally, click **Create**


* Close _Disks_ application


---
### Create and encrypt the Persistent Storage

> Tails Persistent Storage will be created on the remaining free space on the usb drive.


* Choose **Application ▸ Tails ▸ Persistent Storage**.


* Click **Continue**.


* Specify a passphrase of your choice in both the **Passphrase** and **Confirm** text boxes, then click **Create Persistent Storage**.
  
  {: .warning }
  > It is impossible to recover your passphrase if you forget it!


* Wait for the creation to finish.


* Wait for the list of features of the Persistent Storage to appear.
  Each feature corresponds to a set of files or settings that can be saved in the Persistent Storage.


* Turn on the following features, at minimum:
    - [x] Persistent Folder
    - [x] Welcome Screen
    - [x] Electrum Bitcoin Wallet
    - [x] Additional Software
    - [x] Dotfiles
  
    > You can turn on more features later on according to your needs


* Close **Persistent Storage** window.

---
### Encrypt VeraCrypt partition

> Tails comes preinstalled with software to unlock VeraCrypt encrypted partition. However, to encrypt the partition for the first time, VeraCrypt software is needed. We install the VeraCrypt software in RAM, and it disappears when you restart Tails.

* Establish network connection using ethernet cable or Wi-Fi and wait for Tor to be ready.


* Import VeraCrypt PGP Public Key:
  ```shell
  $ torsocks curl https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc | gpg --import
  ```
  and confirm the result:
  ```shell
  >  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
  >                                 Dload  Upload   Total   Spent    Left  Speed
  > 100  5434  100  5434    0     0    264      0  0:00:20  0:00:20 --:--:--   264
  > gpg: key 0x821ACD02680D16DE: 1 signature not checked due to a missing key
  > gpg: key 0x821ACD02680D16DE: "VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>" not changed
  > gpg: Total number processed: 1
  > gpg:              unchanged: 1
  ```


* Download VeraCrypt release:
    * Choose **Applications ▸ Tor Browser**
    * Go to [https://www.veracrypt.fr/en/Downloads.html](https://www.veracrypt.fr/en/Downloads.html){:target="_blank" rel="noopener"}
    * Download latest release of **Linux Generic Installer** and associated **PGP signature**.


* Set VeraCrypt release environment variable:
  ```shell
  VERACRYPT_RELEASE_SEMVER=1.25.9
  ```

* Verify VeraCrypt release file:
  ```shell
  gpg --verify ~/Tor\ Browser/veracrypt-$VERACRYPT_RELEASE_SEMVER-setup.tar.bz2.sig
  ```
  and confirm the result:
  ```text
  > amnesia@amnesia:~$ gpg --verify ~/Tor\ Browser/veracrypt-$VERACRYPT_RELEASE_SEMVER-setup.tar.bz2.sig
  > gpg: assuming signed data in '/home/amnesia/Tor Browser/veracrypt-1.25.9-setup.tar.bz2'
  > gpg: Signature made Sun 20 Feb 2022 01:11:36 PM UTC
  > gpg:                using RSA key 5069A233D55A0EEB174A5FC3821ACD02680D16DE
  > gpg: Good signature from "VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>" [unknown]
  > gpg: WARNING: This key is not certified with a trusted signature!
  > gpg:          There is no indication that the signature belongs to the owner.
  > Primary key fingerprint: 5069 A233 D55A 0EEB 174A  5FC3 821A CD02 680D 16DE
  ```


* Extract VeraCrypt release:
  ```shell
  $ cd ~/Tor\ Browser
  $ tar --extract --file ~/Tor\ Browser/veracrypt-$VERACRYPT_RELEASE_SEMVER-setup.tar.bz2 veracrypt-$VERACRYPT_RELEASE_SEMVER-setup-gui-x64
  ```


* Run installer:
  ```shell
  $ ./veracrypt-$VERACRYPT_RELEASE_SEMVER-setup-gui-x64
  ```

    * then click **Extract .tar Package File**, accept license terms, click **OK** and, finally, click **OK** (again)
    * Enter **2** to Select `2) Extract package file veracrypt_1.25.9_amd64.tar.gz and place it to /tmp`
    * Wait for the result

  ```
  > Installation package 'veracrypt_1.25.9_amd64.tar.gz' extracted and placed in '/tmp'
  > Press Enter to exit... 
  ```

* Extract VeraCrypt binary to `~/VeraCrypt`:
  ```shell
  $ mkdir ~/VeraCrypt
  $ cd ~/VeraCrypt
  $ tar --extract --file /tmp/veracrypt_${VERACRYPT_RELEASE_SEMVER}_amd64.tar.gz --strip-components 2 usr/bin/veracrypt
  ```


* Create `veracrypt.AppImage`:
  ```shell
  $ echo -n "./veracrypt" > veracrypt.AppImage
  $ chmod +x veracrypt.AppImage
  ```

* Mount the `VeraCrypt` partition:
  * Choose **Applications ▸ Utilities ▸ Disks** to start _Disks_ application 
  * select the USB flash drive, click **VeraCrypt Partition 3**, click **>** button (Mount selected partition)
  * Close _Disks_ application


* Launch VeraCrypt:
  ```shell
  $ ~/VeraCrypt/veracrypt.AppImage
  ```

* Wait for _VeraCrypt_ application to start, and proceed to Encrypt Partition:
    * Click **Volumes ▸ Create New Volume...**
    * Select **Encrypt a non-system partition/drive**, click **Next**
    * Select **Standard VeraCrypt volume**, click **Next**
    * Click **Select Device...**
    * Select the partition that is mounted as `/media/amnesia/VeraCrypt`, then click **OK**
    * Click **Next**, then click **Yes** to encrypt the entire device/partition
    * Enter your Tails admin password, then click **OK**
    * Click **Yes** to continue
    * Keep default **Encrypt Options** and click **Next**
    * Enter a volume password and click **Next**
    * Keep option **No** selected and click **Next**
    * Choose filesystem **exFAT** and click **Next**
    * Select **I will mount the volume on other platforms**, click **Next** and **OK**
    * Move the mouse inside the window to increase randomness, then click **Format** to create the volume and **Yes** to confirm
    * Wait for the volume to be formatted, then click **OK**
    * Click **Exit** to exit the VeraCrypt Volume Creation Wizard
    * Click **Exit** to exit the VeraCrypt

---
### Unlocking VeraCrypt partition

* Set-up and administration password when starting Tails.

* Choose **Places ▸ Computer** to start a _Files_ browser.


* In the left pane, select the partition that corresponds to your VeraCrypt volume


* Enter the parameters to unlock the volume, click **Unlock**.




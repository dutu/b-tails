---
layout: page
title: VeraCrypt
parent: Partitions
grand_parent: Install & Configure
nav_order: 2
---

## VeraCrypt

### Install VeraCrypt

* Mount the `VeraCrypt` partition:
  * Choose **Applications ▸ Utilities ▸ Disks**
  * select the USB flash drive, click **VeraCrypt Partition 3**, click **>** button (Mount selected partition)
  * Close **Disks** application


* Establish network connection using ethernet cable or Wi-Fi and wait for Tor to be ready


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


* set VeraCrypt release environment variable:
  ```shell
  $ VERACRYPT_RELEASE_SEMVER=1.25.9
  ```
  
* verify VeraCrypt release file:
  ```shell
  $ gpg --verify ~/Tor\ Browser/veracrypt-$VERACRYPT_RELEASE_SEMVER-setup.tar.bz2.sig
  ```
  and confirm the result:
  ```shell
  > amnesia@amnesia:~$ gpg --verify ~/Tor\ Browser/veracrypt-$VERACRYPT_RELEASE_SEMVER-setup.tar.bz2.sig
  > gpg: assuming signed data in '/home/amnesia/Tor Browser/veracrypt-1.25.9-setup.tar.bz2'
  > gpg: Signature made Sun 20 Feb 2022 01:11:36 PM UTC
  > gpg:                using RSA key 5069A233D55A0EEB174A5FC3821ACD02680D16DE
  > gpg: Good signature from "VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>" [unknown]
  > gpg: WARNING: This key is not certified with a trusted signature!
  > gpg:          There is no indication that the signature belongs to the owner.
  > Primary key fingerprint: 5069 A233 D55A 0EEB 174A  5FC3 821A CD02 680D 16DE
  ```

* extract VeraCrypt release:
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

### Encrypt VeraCrypt Partition

* Launch VeraCrypt:
  ```shell
  $ ~/VeraCrypt/veracrypt.AppImage
  ```

* Wait for VeraCrypt application, and proceed to Encrypt Partition:
  * Click **Volumes ▸ Create New Volume...**, select **Encrypt a non-system partition/drive**, click **Next**, select **Standard VeraCrypt volume**, click **Next**.
  * Select the partition that is mounted as `/media/amnesia/VeraCrypt`, then click **OK**
  * Click **Next**, then click **OK** to encrypt the entire device/partition.
  * Enter admin password
  * Keep default **Encrypt Options** and click **Next**
  * Enter a volume password and click **Next**
  * Choose filesystem **exFAT** and click **Next**
  * Select **I will mount the volume on other platforms**, click **Next** and **OK**
  * Move the mouse inside the window to increase randomness, then click **Format** to create the volume and **Yes** to confirm.
  * Wait for the volume to be created, then click **OK**
  * Click **Exit** to exit the VeraCrypt Volume Creation Wizard.
  * Click **Exit** to exit the VeraCrypt

---
Next:  [Tails Persistent Storage >>](partitions_tailspersistent.html)

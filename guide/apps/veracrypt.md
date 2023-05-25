---
layout: page
title: VeraCrypt
parent: Applications
nav_order: 10
---

## VeraCrypt
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
### Overview

VeraCrypt is a powerful disk encryption software that uses advanced encryption algorithms and techniques to secure your files.
It offers a user-friendly interface, and can create encrypted containers that can be mounted as virtual drives for easy access to your encrypted data.
VeraCrypt is free, open-source, and available for multiple platforms.


![veracrypt.png](/images/veracrypt.png)


> Tails comes preinstalled with software to unlock VeraCrypt encrypted partition. No additional software is needed.<br>
> VeraCrypt application is needed only to create an encrypted partition for the first time, or to create new encrypted file containers.

---
### Install VeraCrypt

* Open a _Terminal_ window:  choose **Applications ▸ Utilities ▸ Terminal**


* Check latest VeraCrypt release:
  ```shell
  $ VERSION=$(wget -qO- https://www.veracrypt.fr/en/Downloads.html | grep -Po 'veracrypt-\K[^-]+(?=-setup.tar.bz2)' | head -1)
  $ echo $VERSION
  ```
  
  > You can also confirm it by checking the official VeraCrypt download page at [https://www.veracrypt.fr/en/Downloads.html](https://www.veracrypt.fr/en/Downloads.html){:target="_blank" rel="noopener"}   


* Download latest release of _Linux Generic Installer_ and associated _PGP signature_:
  ```shell
  $ cd ~/Downloads
  $ wget https://launchpad.net/veracrypt/trunk/$VERSION/+download/veracrypt-$VERSION-setup.tar.bz2
  $ wget https://launchpad.net/veracrypt/trunk/$VERSION/+download/veracrypt-$VERSION-setup.tar.bz2.sig
  ```


* Download VeraCrypt PGP Public Key:
  ```shell
  $ wget https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc
  ```

  
* Import VeraCrypt PGP Public Key and confirm the result: 

  ```shell
  $ gpg --import VeraCrypt_PGP_public_key.asc
  > gpg: key 0x821ACD02680D16DE: 1 signature not checked due to a missing key
  > gpg: key 0x821ACD02680D16DE: public key "VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>" imported
  > gpg: Total number processed: 1
  > gpg:               imported: 1
  > gpg: no ultimately trusted keys found
  ```


* Verify VeraCrypt release file:
  ```shell
  $ gpg --verify veracrypt-$VERSION-setup.tar.bz2.sig
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
  $ tar --extract --file veracrypt-$VERSION-setup.tar.bz2 veracrypt-$VERSION-setup-gui-x64
  ```


* Run installer:
  ```shell
  $ ./veracrypt-$VERSION-setup-gui-x64
  ```

  * Then enter **2** to Select `2) Extract package file veracrypt_1.25.9_amd64.tar.gz and place it to /tmp`
  * Press **Enter** to display the license terms, then **space** to scroll down to the end of license terms
  * Enter **y** to accept the license terms.
  * Wait for the result:
    ```
    > Installation package 'veracrypt_1.25.9_amd64.tar.gz' extracted and placed in '/tmp'
    ```
  * Press **Enter** to exit.


* Extract VeraCrypt binary to `~/VeraCrypt`:
  ```shell
  $ mkdir ~/VeraCrypt
  $ cd ~/VeraCrypt
  $ tar --extract --file /tmp/veracrypt_${VERSION}_amd64.tar.gz --strip-components 2 usr/bin/veracrypt
  ```


* Make the file executable:
  ```shell
  $ chmod +x veracrypt
  ```


* When you want to launch VeraCrypt application execute:
  ```shell
  $ ~/VeraCrypt/veracrypt
  ```

{: .highlight }
Up to this point VeraCrypt is installed in RAM and disappears when you restart Tails. If you need to have VeraCrypt installed persistently, continue with next section.  


---
### Make VeraCrypt application persistent (optional)

* Create VeraCrypt application directory on Persistent Storage and copy the application file:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ sudo mkdir -p $persistence_dir/veracrypt
  $ sudo chown -R amnesia:amnesia $persistence_dir/veracrypt
  $ chmod 700 $persistence_dir/veracrypt 
  $ rsync -av ~/VeraCrypt/ $persistence_dir/veracrypt/
  ```

  
* Add VeraCrypt menu item to the desktop menu:
  ```shell
  $ persistent_desktop_file=$persistence_dir/dotfiles/.local/share/applications/veracrypt.desktop
  $ tar -xvf /tmp/veracrypt_${VERSION}_amd64.tar.gz usr/share/applications/veracrypt.desktop -O > $persistent_desktop_file
  $ tar -xvf /tmp/veracrypt_${VERSION}_amd64.tar.gz usr/share/pixmaps/veracrypt.xpm -O > $persistence_dir/veracrypt/veracrypt.xpm
  $ desktop-file-edit --set-icon="$persistence_dir/veracrypt/veracrypt.xpm" $persistent_desktop_file
  $ desktop-file-edit --set-key="Exec" --set-value="$persistence_dir/veracrypt/veracrypt" $persistent_desktop_file
  $ desktop-file-edit --remove-category="Utility" $persistent_desktop_file 
  $ ln -s $persistence_dir/dotfiles/.local/share/applications/veracrypt.desktop /home/amnesia/.local/share/applications
  ```

---
### Start VeraCrypt

* Choose **Applications ▸ Other ▸ VeraCrypt**

---
### For the Future: Update VeraCrypt

* Follow the steps in section [Remove VeraCrypt persistent installation](#remove-veracrypt-persistent-installation).


* Follow the steps in sections [Install VeraCrypt](#install-veracrypt) and [Make VeraCrypt application persistent (optional)](#make-veracrypt-application-persistent-optional).


---
### Remove VeraCrypt persistent installation

* Remove VeraCrypt application directory:
  ```shell
  $ persistence_dir=/live/persistence/TailsData_unlocked
  $ rm -fr $persistence_dir/veracrypt
  ```


* Remove VeraCrypt menu item from the desktop menu:
  ```shell
  $ rm $persistence_dir/dotfiles/.local/share/applications/veracrypt.desktop
  ```

---
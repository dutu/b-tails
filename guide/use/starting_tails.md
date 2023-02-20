---
layout: page
title: Starting Tails
parent: Use
nav_order: 2
---

{: .no_toc }
# Starting Tails

Follow the steps below to use this memory stick by booting up a computer from the memory stick.

- TOC
 {:toc}



## Starting Tails on Windows, Linux or MAc

{: .highlight }
> For more detailed instruction on how to boot from USB see [Starting Tails](https://tails.boum.org/doc/first_steps/start/index.en.html){:target="_blank" rel="noopener"}.


* Identify the possible Boot Menu keys for the computer to boot up from USB.
  {: .highlight }
  Most computers do not start from USB directly, but after the computer is switched on you can press a Boot Menu key to display a list of possible devices to start from.

  On many computers, a message is displayed very briefly when switching on that explains how to get to the Boot Menu or edit the BIOS settings.

  Depending on computer manufacturer the Boot Menu Key can be one in the following list:

  **Manufacturer** | 	**Key**
  Acer	| F12, F9, F2, Esc
  Apple	| Option
  Asus	| Esc
  Clevo	| F7
  Dell	| F12
  Fujitsu	| F12, Esc
  HP	| F9
  Huawei	| F12
  Intel	| F10
  Lenovo	|F12
  MSI	| F11
  Samsung	| Esc, F12, F2
  Sony	| F11, Esc, F10
  Toshiba	| F12
  others…	| F12, Esc
 

* Shut down the computer and plug in the B-Tails USB stick



* Switch on the computer.
  Immediately press several times the Boot Menu key identified in first step.


* If the computer starts normally or returns an error message, shut down the computer again and repeat previous step for another possible Boot Menu key.


* If a Boot Menu with a list of devices appears, select your USB device and press **Enter**.


* If the computer starts on USB stick, screen below appears and Tails starts automatically after 4 seconds.

  ![](..\..\images\grub.png)


## Welcome Screen

* One to two minutes after computer has booted from the USB stick, the Welcome Screen appears.

  ![](..\..\images\welcome_screen_with_persistence.png)


* Unlock Persistent Storage:
  * Enter your password for the Persistent Storage, then click **Unlock**


* Set up an administration password:
  * Under **Additional Setting** , click the **+** button
  * Choose **Administration Password** in the **Additional Settings** dialog
  * Specify a password of your choice in both the **Administration Password** and **Confirm** text boxes then click **Add**


* Click **Start Tails**


## Tails Desktop

* 15–30 seconds after Tails has been, the Tails desktop appears.

  ![](..\..\images\tails_desktop.png)


## Unlock VeraCrypt partition

VeraCrypt encrypted partition can be unlocked every time when Tails is started.

* Choose **Applications ▸ Utilities ▸ Unlock VeraCrypt Volumes**


* Under **Partitions and Drives**, click **Unlock**


* Enter the password for VeraCrypt volume and click **Unlock**


* Enter admin password and click **Authenticate**


* Click **Open** button


* You can now close the **Unlock VeraCrypt Volumes** application


## Connect to internet

* Open the system menu by clicking on the top-right corner.


* If a wired connection is detected, Tails automatically connects to the network


* To connect to a Wi-Fi network:
  * Choose **Wi-Fi Not Connected** and then **Select Network**

  {: .highlight }
  > If there is no option to connect to a Wi-Fi network, your Wi-Fi adapter is not working in Tails. See the documentation on [troubleshooting Wi-Fi not working](https://tails.boum.org/doc/anonymous_internet/no-wifi/index.en.html){:target="_blank" rel="noopener"}.


* To connect to a mobile data network
  * Choose **Mobile Broadband**


* After you connect to a local network, the **Tor Connection** assistant appears


* Choose **Connect to Tor automatically** and click **Connect to Tor**

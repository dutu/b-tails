---
layout: page
title: FAQ
nav_order: 91
---

{: .no_toc }
# FAQ 

- TOC
{:toc}

---
## How can I open a  file browser with administration rights in Tails?

* Choose **Application ▸ System Tools ▸ Root Terminal**. and enter admin password

* In the terminal, run:
  ```shell
  $ nautilus
  ```

---

## How can I launch the latest Electrum manually?

* Find the name of the Electrum AppImage file:

  ```shell
  $ ls -ls /live/persistence/TailsData_unlocked/electrum/*.AppImage
  ```
  If the AppImage file is not found, you can proceed with [Installation of Electrum Bitcoin Wallet](install/electrum.html) 
  

* Launch the AppImage. Example:

  ```shell
  $ /live/persistence/TailsData_unlocked/electrum/electrum-4.3.3-x86_64.AppImage
  ```

{: .highlight }

---
---
layout: page
title: FAQ
nav_order: 9
---

{: .no_toc }
# FAQ 

- TOC
{:toc}

## Tails

---
### How can I access the Persistent Storage

* Choose **Application ▸ Persistent Storage**


---

### How to start Tails with an administration password?

In order to perform administration tasks, you need to set up an administration password when starting Tails.

* Boot up on Tails

* When **Welcome to Tails Screen!** appears, click **+** button.

  ![welcome_screen.png](..%2Fimages%2Fwelcome_screen.png)


* Choose **Administration Password** in the **Additional Settings** dialog.


* Specify a password of your choice in both the **Administration Password** and **Confirm** text boxes, then click **Add**.


* Click **Start Tails**.


---
### How can I access the VeraCrypt encrypted partition?

See [Unlock VeraCrypt partition](https://dutu.github.io/b-tails/guide/use/on_tails.html#unlock-veracrypt-partition).


---

### How can I open a file browser with administration rights in Tails?

* Choose **Application ▸ System Tools ▸ Root Terminal**. and enter admin password.


* In the terminal, run:
  ```shell
  $ nautilus
  ```

## Electrum

### How can I open a bitcoin wallet?
You can use Electrum Bitcoin Wallet application.<br>
See [Use Electrum Bitcoin Wallet](https://dutu.github.io/b-tails/guide/use/electrum.html).




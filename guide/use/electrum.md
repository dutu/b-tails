---
layout: page
title: Electrum Bitcoin Wallet
parent: Use on Tails
grand_parent: Use
nav_order: 12
---

# Use Electrum Bitcoin Wallet

## Prerequisites 

- [x] Your computer is started Tails from USB memory stick
- [x] Persistance Storage is unlocked
- [x] VeraCrypt encrypted partition is unlocked
- [x] You have cooection to internet

Check: [Use on Tails](on_tails.html)  


## Start Electrum Bitcoin Wallet

* You can now start Electrum Bitcoin Wallet:
  * Choose **Applications ▸ Other ▸ Electrum Bitcoin Wallet**


## Open your wallet

* Click **Choose...** button

* Select your wallet file:

  - [ ] **If your wallet file is on VeraCrypt encrypted partition:**
    * Look in folder `/media/amnesia/`. Here your partition is listed (mounted) as a folder
    * Browse to your wallet file, select it and click **Open**, then click **Next**

  - [ ] **If your wallet file is on Tails Persistent Storage:**
    * Look in folder `/home/amnesia/Persistent`
    * Browse to your wallet file, select it and click **Open**, then click **Next**

  - [ ] **If your wallet file is on another USB drive:**
    * Insert your USB drive into another USB port
    * On Tails Desktop menu choose **Places ▸ Computer**
    * You should then see your USB drive listed on the left part of the window. Click on it to mount and open
    * Return to Electrum application and look in folder `/media/amnesia/`. Here your USB drive is listed (mounted) as a folder
    * Browse to your wallet file, select it and click **Open**, then click **Next**
  
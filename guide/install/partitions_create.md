---
layout: page
title: Create partitions
parent: Partitions
grand_parent: Install & Configure
nav_order: 1
---

## Create Partitions

* Make sure Tails OS installation has been completed.


* Boot to Tails from the USB stick. After one or to minutes **Welcome to Tails!** screen appears.


* Set admin password:
  * Click **+** under **Additional Settings**
  * Click **Administration Password**
  * enter password
  * click **Add**


* Start Tails:
  * Click **Start Tails**


* Create the `README` partition:
  * Choose **Applications ▸ Utilities ▸ Disks**
  * Select the USB flash drive
  * Click **Free Space**, then **+**, set **Partition Size** to `512 MB`, click **Next**
  * Set **Volume Name** to `README`, select **Other**, click **Next**
  * Select **exFAT** and, finally, click **Create**


* Create `VeraCrypt` partition
  * Click **Free Space**, then **+**, set **Partition Size** to `2048 MB`, click **Next**
  * Set **Volume Name** to `VeraCrypt`, select **Other**, click **Next**
  * Select **exFAT** and, finally, click **Create**
  * Close **Disks** application

---
Next:  [VeraCrypt >>](partitions_veracrypt.html)
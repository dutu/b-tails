---
layout: page
title: Partitioning
nav_order: 3
---

# Partitioning

## Overview

We partition the USB memory stick to have the following structure:

![](../images\disk_layout.png)

1. **`Tails`** - partition where the Tail OS has been installed.
2. **`README`** - 512MB exFAT partition. It will be an unencrypted partition that can be used to store insensitive data.
3. **`VeraCrypt`** - 2GB exFAT partition. It will be encrypted with VeraCrypt. Should be used to store private files.
4. Free space - it will be used for Tail OS Persistent Storage. Partition will be encrypted.

{: .warning }
>The size of the Partitions 2-4 can be adjusted when created. Values above are proposed settings.

## Create partitions

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
  * Click **Aplications**, **Utilities**, then **Disks**
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
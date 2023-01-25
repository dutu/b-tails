---
layout: page
title: Tails Utilities
parent: Applications
grand_parent: Install & Configure
nav_order: 2
---

# Tails Utilities
{: .no_toc }

Some utility apps are installed, that comes in handy for other applications to work properly. 

- TOC
{:toc}


## Tails Autostart

[Tails Autostart](https://github.com/dutu/tails-autostart){:target="_blank" rel="noopener"} is a utility script that automatically starts scripts/applications on Tails bootup.

This facilitates Signal application to work.

### Install Tails Autostart
{: .no_toc }

* Boot on Tails and make sure Persistent Storage is unlocked.


* Clone [**Tails Autostart** repository](https://github.com/dutu/tails-autostart){:target="_blank" rel="noopener"} and move files to autostart:
  ```shell
  $ cd ~/Downloads
  $ mkdir -p /live/persistence/TailsData_unlocked/dotfiles/.config/autostart
  $ torsocks git clone https://github.com/dutu/tails-autostart.git /live/persistence/TailsData_unlocked/dotfiles/.config/autostart
  ```


---
Next:  [Signal >>](signal.html)



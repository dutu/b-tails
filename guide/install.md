---
layout: page
title: Install & Configure
nav_order: 10
has_children: true
---

# Install and Configure

This guide explains how to setup your USB memory drive to use it as a bootable USB drive and as an encrypted drive to store securely your personal data.


```mermaid
flowchart TB
subgraph tails [Bootable OS]
  direction TB
  A(Install Tails)
end
subgraph partitions [Partitions]
  direction TB
  B(Create partitions)-->C(Encrypt partitions)
end
subgraph apps [Applications]
  direction TB
  D(Install Utilities)-->E(Install Electrum) 
  D(Install Utilities)-->F(Install Signal)
end
tails-->partitions
partitions-->apps
```

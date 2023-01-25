#!/bin/sh

persistence_dir=/live/persistence/TailsData_unlocked
mkdir -p /home/amnesia/.var/app
ln -s $persistence_dir/signal /home/amnesia/.var/app/org.signal.Signal

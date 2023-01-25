#!/bin/sh

persistence_dir=/live/persistence/TailsData_unlocked
mkdir -p $persistence_dir/signal
mkdir -p /home/amnesia/.var/app
ln -s $persistence_dir/signal /home/amnesia/.var/app/org.signal.Signal

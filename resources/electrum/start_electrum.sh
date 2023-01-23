#!/bin/bash

persistence_dir=/live/persistence/TailsData_unlocked
electrum=$(find ${persistence_dir}/electrum/*.AppImage | tail -n 1)

server=g4ishflgsssw5diuklqsgdb5ppsz5t2sxevysqtfpj27o5xnjbzit4qd.onion:50002:s

${electrum} -1 --forgetconfig


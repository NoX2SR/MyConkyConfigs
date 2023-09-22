#!/bin/bash

sleep 7 && conky -c ~/.config/conky/conky_cpu.conf
conky -c ~/.config/conky/conky_ram.conf
conky -c ~/.config/conky/conky_hdd.conf
conky -c ~/.config/conky/conky_gpu.conf
conky -c ~/.config/conky/conky_wifi.conf
conky -c ~/.config/conky/conky_lan.conf
conky -c ~/.config/conky/conky_system.conf
conky -c ~/.config/conky/conky_audio.conf
conky -c ~/.config/conky/conky_bios.conf
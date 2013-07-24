Kickstart -- Test branch
=========

Kickstart files and helpers for dev and stable environments.

## Archlinux
The kick for archlinux is based mostly upon github.com/altercation:s archblocks. The key difference is unattended installation, gpt with grub support. I will add EFI when i have hardware that supports it.

    archlinux.ks
    ./archlinux/

First file is the kickstart template where you configure the system via variables. The directory includes helper files and configuration.


## Centos

## Debian

## Gentoo
Take a look at ./Gentoo-HAI/. I have not tested this yet.

## Helpers
    ./customhttpserver
Is a simple http server in python where you can define the port yourself. Running customhttpserver within this directory will allow you to install multiple systems at once. Due to the small size of files being served using the script latency is not an issue as with larger files.

    ./createiso.sh
A helper file to build a custom iso for centos where the boot variable can be customized ie you can set the ks variable and have the iso load your kickstart automatically. Rebuilding iso will also affect filesize. The CentOS-6.3-x86_64-netinstall.iso is 200M and with this script you can reduce the size to ~50M.

    ./postinstall
    ./firstboot
Is a system for postinstallation of puppet in debian environments. It is not in use at the moment but working code was commented out.

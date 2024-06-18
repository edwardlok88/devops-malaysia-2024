# Day 1

## What is Dual/Multi Booting?
<pre>
- Boot Loader is a system utility which get installed in the Master Boot Record(MBR) in the hard disk
- it is 512 bytes, hence the boot loader software has to fit within the MBR ( Sector 0, Byte 0 in Hard Disk )
- Once the BIOS POST(Power ON Self Test) is complete, the BIOS will instruct the CPU to load and run the Boot Loader
- The boot loader application then scans the hard disks looking for Operating System installed
- In case the boot loader finds more than one OS, it then prepare a menu and displays the menu for us to choose which OS we wish boot into
- Examples for Boot Loader
  - Opensource Linux Boot Loaders
    - LILO ( Linux Loader )
    - GRUB 2 ( capable of booting Windows/Linux )
  - Commerical Boot Loaders
    - BootCamp ( Mac OS-X )
- Though we can have multiple OS installed on the same Laptop/Desktop, only OS can be active at any point
</pre>

## Hypervisor Overview

## Hypervisor High Level Architecture

## Containerization Overview

## What is Container Runtime?

## What is Container Engine?

## Docker High Level Archtitecture

## Docker Registries

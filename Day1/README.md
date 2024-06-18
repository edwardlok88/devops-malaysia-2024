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

## Processors
- comes in 2 types of packaging
  - SCM (Single Chip Module)
    - a single IC will have a single Processor
  - MCM (Multi Chip Module)
    - a single IC will have multiple Processors
- each Processor might support multiple CPU cores
- server grade motherboards generally support multiple processor sockets
- 8 Processor Socket Motherboard
- Imagine if we install a MCM with 4 processor/per Socket
- Total 32 Processors with 128 cores/processor

- Imagine each Processor supports 128 cpu cores
- With Hyperthreading features, each physical CPU core is capable of running 2 threads parallel,
- in layman term, each Phyiscal cpu core is equivalent to 2 virtual cores
- Total virtual cores - 32 * 128 * 2 = 8192

## Hypervisor Overview
<pre>
- is aka virtualization
- virtualization technology allows us to run multiple OS in a laptop/desktop/workstation/server at the same time
- in other words, many OS can be actively running side by side on a single machine
- the primary OS on which the virtualization software is installed is called as Host OS
- the Operating System that are installed with the Virtualization software (hypervisor) is called Guest OS or Virtual Machine(VM)
- each VM has to allocated with dedicated hardware resources
  - CPU
  - RAM
  - Hard disk storage
  - Network ( virtual )
  - Graphics Card ( Virtual )
- Hypervisors are of two types
  1. Type 1 - Bare Metal Hypervisors - Used in Workstations/Servers
  2. Type 2 - Used in Laptops/Desktops/Workstations
- Examples
  Type 1 - VMWare vSphere/vCenter
  Type 2 ( has to installed on top of Host OS )
  - VMWare Fusion (Mac OS-X)
  - VMWare Workstation ( Windows & Linux )
  - Oracle VirtualBox ( Mac, Linux & Windows - Free )
  - KVM - opensource (Linux)
  - Microsoft Hyper-V 
- It is a Hardware + Software Technology
  Processors
  - AMD - the virtualization feature set supported by AMD is called AMD-V
  - Intel - the virtualization feature set supported by Intel is called VT-X
- this type of virtualization is called heavy weight virtualization as each VM requires dedicated h/w resources
- How many physical servers/machines required to support 1000 OS in the absence of Virtualization technology
  - 1000 Servers
- With virtualization technology, what is the minimal physical servers required to support 1000 OS?
  - technically it is possible to host 1000 virtual machine in a single server
- virutalization technology helps organization in server consildation with few number of physical server
- each VM represents one fully function Operating System
- each OS that runs within a VM has its own dedicated OS Kernel
</pre>

## Hypervisor High Level Architecture

## Containerization Overview
- it is an application virtualization technology
- it is light-weight as container don't required dedicated hardware resources
- each container runs one application or application component
- container has application and its dependent libraries and dependencies bundled together as a single unit
- container represents application
- container is a not an Operating Systems
- containers will never be able to replace a Virtual Machine(OS)
- container and Virtualization are complementing technologies not competing technologies
- container is an application process
- containers doesn't OS Kernel
- similarities between a Virtual Machine and Containers
  - Just like VMs acquire IP address, the container also gets its own IP address
  - Just like VMs has their own file system, the container also has their own file system
  - Just like VMs has their own Network Card, the container also has their own Network Card
  - Just like VMs has a Network Stack, containers also has their own Network stack
  - Just like VMs has its own Port range, container also has their own Port range ( 0-65535 ports )
## What is Container Runtime?

## What is Container Engine?

## Docker High Level Archtitecture

## Docker Registries

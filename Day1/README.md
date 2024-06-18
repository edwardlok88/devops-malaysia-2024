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

## Linux Kernel Features that supports Containerization
1. Namespace
2. Control Groups (CGroups)
   - helps in applying resource quota restrictions to individual containers
   - we can apply restriction like
     - how much maximum cpu resources a container can utilize at any time
     - how much RAM a container can use at any time
     - how much disk space a contianer can use 

## What is a Container Image?
<pre>
- is a bluesprint or specification of a Containerized application
- whatever software tools/libs we need in the container are installed in the container image
- using container image we can create one or more containers
- containers are the running instances of container image
</pre>  
 
## What is Container Registry?
<pre>
- is generally a web server that hosts multiple container images for us upload/download container images
- there are 3 types of Container Registries
  - Local Container Registry (which is a folder under user home directory )
  - Private Container Registry
    - can be setup using JFrog Artifactory or Sonatype Nexus
  - Remote Container Registry ( eg - Docker Hub website )
</pre>  

## What is Container Runtime?
<pre>
- is a low-level software that manages container images and container life cycle
- it is not so user-friendly, hence end-users like us don't normally use the container runtime softwares
- examples
  - runC 
  - CRI-O 
</pre>

## What is Container Engine?
<pre>
- Container Engine is a high-level software that manages container images and container life cycle
- Container Engines internally depends on Container Runtime software to manage images and containers
- very user-friendly, don't have know linux kernel knowledge Or OS low-level details to create containers
- examples
  - Docker is a Container Engine which uses containerd internally, containerd depends on runC container runtime
  - Podman is a Container Engine which uses CRI-O container runtime internally
</pre>

## Docker High Level Archtitecture

## Docker Registries

## Lab - Finding the docker version ( Windows command prompt or Linux Terminal )
```
docker --version
docker info
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/84e5f9a2-9c8b-4ee8-8af5-425aae2e575c)

## Lab - Listing and downloading docker images

Listing docker images from your local docker registry
```
docker images
```

Downloading docker image from Docker Hub Remote Registry to your Local Docker Registry
```
docker pull ubuntu:16.04
docker pull ubuntu:18.04
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/7b98899d-7253-491f-ab3b-afe50899d3a4)



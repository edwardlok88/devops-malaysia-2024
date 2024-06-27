# Day 8

## What is Cloud Computing ?
- most of the organization are switching to public cloud to address their increasing Infrastructure demand
- instead of procuring your own Server, we could hire them for public cloud vendors like AWS, Azure, GCP, Digital Ocean, etc.,
- Server grade motherboard comes with many Processor Sockets
- Processors comes with different types of Packaging
  1. SCM (Single Chip Module - 1 IC will contain just 1 Processor )
  2. MCM (Multiple Chip Module - 1 IC will contain many Processors )
- 8 Socket Server Motherboard
  - If you install MCM IC with 4 Processors
  - 32 Processors
  - Each Processor can support 128/256/512 CPU Cores- Software as a Service ( SaaS)

  - Total Physical Cores - 4096 CPU Cores
## Why do we need Cloud Computing ?

## Types of Cloud Computing Services ?
- Infrastructure as a Service (IaaS)
   - In this the cloud vendor just provides the hardware (Server)
   - We need to bring our own OS and license
   - We rent only the Server, installing OS, installing softwares, updating sofwares, service packs, security patches is our responsibility
   - We need to take backup of our data
- Platform as a Service (PaaS)
   - the cloud vendor provides Hardware + OS
  - Hardware + OS + Software provided by the Cloud vendor
  - In this model, OS license, Software license is the responsibility of Cloud vendor
  - Taking backup of Oracle or application data is responsibility of cloud vendor  
- Function as a Service ( FaaS)
  - AWS Lamba Functions
  - Your service runs when some one attempts to access your web service
  - Usually a container will be created on demand and your applicaiton will run within the container to respond to your users
  - If your application is idle, the container will be removed
  - When no one is accessing your service, you only pay for the storage your application code uses in public cloud

## Types of Cloud
1. Private Cloud
2. Public Cloud
3. Hybrid Cloud

## What is Private IP Address?
<pre>
- in most of the cases, each device at work will be assigned a Private IP address which is unique within your office network
- all the machines in that office network are assured to have an unique ip
- any machine which is connected in the same network, they can ping each other
- any machine/device which is outside your office network can't communication(ping) with the machines connected to your office network
- with Private IP, your machines can access Internet
- but from Internet, no one can access your machine, Private IP secures your machines
</pre>

## What is Public IP?
<pre>
- machines with public IP can be accessed from any network
- they are accessible from Internet
</pre>

## What is Static Public IP?
<pre>
- One one person in the entire world can have that Static Public IP
- in other words, the IP address is unique over Internet(Word wide web)
- Each company website url is assigned with an unique static Public IP
- If you website is behind loadbalance/gateway, they are assigned with Static
- To get Static PUblic IP - there is a cost, you are technically buying that Static Public IP
- Any machine assigned with static IP will not change when the laptop/desktop/worstation/server is rebooted
</pre>

## What is Dynamic Public IP
<pre>
- machines with Dynamic Public IP are accessible over Internet
- the Dynamic Public IP is uniques in World Wide Web(Internet)
- When the machine with dynamic public ip is restarted, the IP will change
</pre>

## What is a VPN?
<pre>
- Virtual Private Network
- 10.10.0.0/16 (31 bits - IPV4 Address)
- How many IP addresses are there in 10.10.0.0/16?
  - 256 * 256 = 65535 IP addresses are there in 10.10.0.0/16 network
- A.B.C.D
- A is 1 byte(8 bits - 0 - 255)
- B is 1 byte(8 bits)
- C is 1 byte(8 bits)
- D is 1 byte(8 bits)
- First IP in 10.10.0.0/16 is 10.10.0.0
- Second IP is 10.10.0.1
  
</pre>

## What is Subnet?
<pre>
- is a logical network created out of Virtual Private Network
- 10.10.0.0/16 (VPN)
  - 10.10.1.0/24 Subnet 1 (IT Department)
    - System Admin 1 Laptop
    - System Admin 2 Laptop
  - 10.10.2.0/24 Subnet 2 ( Accounts )
    - Accounts Employee 1
    - Accounts Employee 2
  - 10.10.3.0/24 Subnet 3 ( Engineering Dept )
  - 10.10.3.0/24 Subnet 3
</pre>


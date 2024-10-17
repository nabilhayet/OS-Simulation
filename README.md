![GitHub Repo stars](https://img.shields.io/github/stars/nabilhayet/OS) ![GitHub forks](https://img.shields.io/github/forks/nabilhayet/OS) ![GitHub followers](https://img.shields.io/github/followers/nabilhayet) ![Bitbucket open issues](https://img.shields.io/bitbucket/issues/nabilhayet/OS)                                          
                                        <h1>:jack_o_lantern: OS Simulation :jack_o_lantern: </h1>
                                                      
This project offers a comprehensive demonstration of how an operating system functions. It simulates the creation of various processes and their management in memory and on the hard disk. While it doesn't execute real processes, the system's design and mechanisms provide valuable insights into prioritizing tasks. Exploring the parent-child relationship among processes illustrates the interconnectedness and dependencies within a system. 

<a href="https://www.youtube.com/watch?v=huwac5JMfS8">Demo</a>

Table of Contents
- [Features](#features)
- [Tech-Stack](#tech-stack)
- [Installing](#installing)
- [Challenges](#challenges)
- [Future-Implementation](#future-implementation)
- [Code-Snippet](#code-snippet)
                               
## Features
<ul>
   <li>Create a process in the system</li>
   <li>Have a CPU to keeep track of current process</li>
  <li>Create Ready-Queue to hold processes waitting to use CPU</li>
  <li>Create Hard-Disk to move processes from CPU</li>
  <li>Create parent-child relationship objects to keep track of different process.</li>
  <li>Edit/Delete a process based on any input</li>
  <li>Create Zombie process</li>
  <li>Display status of any process</li>
  <li>Display status of different memory management</li>
</ul>

## Create Process

![Create_Process](https://github.com/user-attachments/assets/d4ee511e-7bbc-4897-a7d9-4fc03c464010)

## CPU Status

![Process_Status](https://github.com/user-attachments/assets/96d01062-403d-439a-b48c-177d2b162bf8)

## Ready Queue

![Ready_Queue](https://github.com/user-attachments/assets/f0425ef2-b5c2-44f9-8b68-ba2b9f39ff03)

## Create Hard Disk

![Hard_Disk](https://github.com/user-attachments/assets/056ed0d0-7da1-4e17-a7cf-d68dc6bd5366)

## Parent Child Relation

![Memory](https://github.com/user-attachments/assets/c6695c60-6d05-4e84-94a8-3c654fdf2d18)

## Delete Process

![Delete_Process](https://github.com/user-attachments/assets/1d400058-773f-482b-b649-43c45f40271f)

## Create Zombie Process

![Zombie_Process](https://github.com/user-attachments/assets/96f2e30d-ce34-4151-8f48-c7211a00e49b)

## Memory Management Status

![Memory_management](https://github.com/user-attachments/assets/2d12105f-b17a-4446-9e8c-92fb5071d1fc)

## Tech-Stack
<p>This cli app makes use of the following:</p>
* ruby '2.6.1'
* 'bcrypt', '~> 3.1.7'

## Installing
<ul>
   <li> Clone this repo to your local machine git clone <this-repo-url></li>
  <li> run brew update and brew install ruby to install required dependencies</li>
  <li> run gem install pry to debug</li>
  <li> run 'ruby main.rb'</li>
</ul>
        
## Challenges
<ul>
  <li> Connecting multiple memory management like CPU, Hard Disk, Ready-Queue</li>
  <li> Creating parent child nested processes</li>
  <li> Creating System design for each memory management</li>
  <li> Adding/removing a nested process</li>
</ul>

## Future-Implementation
<ul>
  <li>Creating real time processes to get actual simulation</li>
  <li>Adding other memory management like RAM, ROM etc</li>
  <li>Adding multiple machines/systems</li>
</ul>

## Code-Snippet 

```
while(input != 'Exit')
  if(input == 'A')
    CreateProcess(input)
  elsif(input == 'Q')
    ProcessQueueAdjust()
  elsif(input == 'fork')
    CreateProcess(input)
  elsif(input == 'S r')
    ProcessStatus()
  end 
end 
```
```
def CreateProcess(input)
  @process =  Pid.new($pid)
  $pid = @process.findObject
  $process_array.push(@process)
  $ready_queue.push(@process.pid)
  if($cpu == 0 && $ready_queue.length > 0)
    $cpu = $ready_queue[0]
    $ready_queue.shift()
  end
  MemoryUtilization(input)
end 

```
```

class Pid
  attr_accessor :pid
  def initialize(pid)
    @pid = pid+=1
  end 

  def findObject
    @pid 
  end 
end 
```
```

def HardDiskStatus
  puts "The hard disk number being used now : "
  $hard_disk.each do |hard_disk_num, hard_disk_info|
    puts hard_disk_num
    puts "---------------------"
    hard_disk_info.each do |h,d|
      puts "The #{h} is - #{d}"
    end 
    puts "-------------------"
  end 
end 
```




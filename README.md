![GitHub Repo stars](https://img.shields.io/github/stars/nabilhayet/OS) ![GitHub forks](https://img.shields.io/github/forks/nabilhayet/OS) ![GitHub followers](https://img.shields.io/github/followers/nabilhayet) ![Bitbucket open issues](https://img.shields.io/bitbucket/issues/nabilhayet/OS)                                          
                                        <h1>:jack_o_lantern: OS Simulation :jack_o_lantern: </h1>
                                                      
This project offers a comprehensive demonstration of how an operating system functions. It simulates the creation of various processes and their management in memory and on the hard disk. While it doesn't execute real processes, the system's design and mechanisms provide valuable insights into prioritizing tasks. Exploring the parent-child relationship among processes illustrates the interconnectedness and dependencies within a system. 
<a href="">Demo</a>

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


## CPU Status


## Ready Queue


## Create Hard Disk

## Parent Child Relation


## Delete Process


## Create Zombie Process
## Memory Management Status


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




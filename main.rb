require './Pid.rb'
require 'pry'
puts "------------------------------"
$pid = 0
$cpu = 0
$process_array = Array.new
$parent_child_process = Hash.new 
$ready_queue = Array.new 
$processing_waiting_queue = Array.new
$hard_disk_input = Array.new
$hard_disk = Hash.new
$disk_remove_input = Array.new 
$wait_quit = Hash.new
$zombie_process = Hash.new
$waiting_state_parent_zombie_process = Array.new
$process_has_parent = false 

puts "How many Hard Disks does the computer Have?"
$hard_disks_number = Integer(gets.chomp)

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

def MemoryUtilization(input)
  if(input == 'A')
   $parent_child_process[@process.findObject] = []
  elsif(input == 'fork')
    ($parent_child_process[$cpu] ||= []) << @process.findObject
  end 
  puts $parent_child_process
end 

def ProcessStatus
  puts "----------------------"
  puts "The parent child process #{$parent_child_process}"
  puts "The process using the cpu #{$cpu}"
  puts "The processes waitting in ready queue to use cpu are #{$ready_queue}"
end 

def ProcessQueueAdjust
  if($cpu != 0)
    $ready_queue.push($cpu)
    $cpu = 0
  end 
  if($cpu == 0)
    $cpu = $ready_queue[0]
    $ready_queue.shift()
  end 
  puts "The process using CPU is #{$cpu}"
  puts "The Ready Queue looks like: #{$ready_queue}"
end 

def HardDiskRead
  puts "Hello World"
  $hard_disk_input[1] = Integer($hard_disk_input[1])

  if(!$hard_disk.has_key?($hard_disk_input[1]))
    $hard_disk[$hard_disk_input[1]] = {}
    $hard_disk[$hard_disk_input[1]]["process"] = {}
    $hard_disk[$hard_disk_input[1]]["IOQueue"] = []
    $hard_disk[$hard_disk_input[1]]["processqueuefile"] = {}
  end 

  # That means it hhas been read already
    if(($hard_disk[$hard_disk_input[1]]["process"]).empty?)
      $hard_disk[$hard_disk_input[1]]["process"][$cpu] = $hard_disk_input[2]
    else
      $hard_disk[$hard_disk_input[1]]["IOQueue"] << $cpu
      $hard_disk[$hard_disk_input[1]]["processqueuefile"][$cpu] = $hard_disk_input[2]
    end 
    $cpu = 0
    $cpu = $ready_queue[0]
    $ready_queue.shift()

  puts $hard_disk
end 
 
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

def HardDiskAdjust
  puts "I am inside Hard Disk Adjust"
  puts "-----------------------------"
  if($hard_disk[$disk_remove_input[1]]["process"].empty?)
    puts "No Process is using #{$disk_remove_input[1]}"
  else
    ($hard_disk[$disk_remove_input[1]]["process"]).each do |h,k|
      $ready_queue.push(h)
    end 
  end 

  puts "The Ready queue is #{$ready_queue}"

  $hard_disk[$disk_remove_input[1]]["process"] = {}
  puts $hard_disk

  if(($hard_disk[$disk_remove_input[1]]["IOQueue"]).length > 0)
    a = $hard_disk[$disk_remove_input[1]]["IOQueue"][0]
    b = $hard_disk[$disk_remove_input[1]]["processqueuefile"][a]

    $hard_disk[$disk_remove_input[1]]["process"][a] = b 
    $hard_disk[$disk_remove_input[1]]["IOQueue"].shift()
    puts $hard_disk

    $hard_disk[$disk_remove_input[1]]["processqueuefile"].delete(a)
    puts $hard_disk
  end 

  if($cpu == 0)
    $cpu = $ready_queue[0]
    $ready_queue.shift()
  end 
end 

def RemoveProcess(input)
  puts "-----------------------"
  puts "I am inside Remove Process"
  $wait_quit[$cpu] = input
  parent_process = nil 

  # IF a process asks 'quit' but it has children in hard disk I/O Delete them also here 
  if($cpu != 0)
    $parent_child_process.each do |parent,child| 
      if(parent == $cpu)
        $ready_queue.delete_if {|item| $parent_child_process[$cpu].include?(item) }
        $parent_child_process[parent].clear()
      end 
    end 
  end 

  if($cpu != 0)
    $parent_child_process.each do |parent,child| 
      if($parent_child_process[parent].include?($cpu))
        $process_has_parent = true 
        parent_process = parent
        break
      end 
    end 
  end 

  if($process_has_parent)
    if($wait_quit[parent_process] == 'wait')
      $parent_child_process.delete($cpu)
      $parent_child_process[parent_process].delete($cpu)
      $wait_quit.delete($cpu)
      $wait_quit.delete(parent_process)
      $ready_queue.push(parent_process)
      $waiting_state_parent_zombie_process.delete(parent_process)
    #  $zombie_process[parent_process].delete($cpu)
      $cpu = 0
    else
      ($zombie_process[parent_process] ||= []) << $cpu
      $cpu = 0
    end 
  else
    $parent_child_process.delete($cpu)
    $ready_queue.delete($cpu)
    $wait_quit.delete($cpu)
    $cpu = 0
  end 

  if($ready_queue.length > 0 && $cpu == 0)
    $cpu = $ready_queue[0]
    $ready_queue.shift()
  end  
  puts "The parent child processes are #{$parent_child_process}" 
  puts "The Zombie process relationship #{$zombie_process}" 
  puts "The Processes waiting to quit & wait are #{$wait_quit}"
end 

def WaitParentProcess(input)
  puts "--------------------"
  puts "I am inside Parent Wait Process"
  $wait_quit[$cpu] = input 

  if($parent_child_process[$cpu].length == 0)
    puts "No need to wait, the process can continue as it has no child"
  else 
    if($zombie_process.has_key?($cpu) && $zombie_process[$cpu].length > 0)
      $wait_quit.delete($cpu)
      $wait_quit.delete($zombie_process[$cpu][0])
      $parent_child_process.delete($zombie_process[$cpu][0])
      $parent_child_process[$cpu].delete($zombie_process[$cpu][0])
      $zombie_process[$cpu].shift()
      $zombie_process.each do |key,value|
        if(value.length == 0)
          $zombie_process.delete(key)
        end 
      end 
    else
      $cpu = 0
      $waiting_state_parent_zombie_process.push($cpu)
    end 
  end 

  if($ready_queue.length > 0 && $cpu == 0)
    $cpu = $ready_queue[0]
    $ready_queue.shift()
  end  
end 

def ShowInfo
  puts "The Process using CPU IS : #{$cpu}"
  puts "The processes are #{$process_array}"
  puts "The parent child processes are #{$parent_child_process}"
  puts "The processes waiting in ready queue to use CPU are #{$ready_queue}"
  puts "The processes waiting to wait hard disk #{$processing_waiting_queue}"
  puts "The Hard disk structure is #{$hard_disk}"
  puts "The processes waiting to quit are #{$wait_quit}"
  puts "Thhe Zombie processes are #{$zombie_process}"
end 

def FindProcessId
   puts "The Process id is #{@process.findObject}"
end 

def ShowAllProcess
  puts "The processess are #{$process_array[0]}"
end 
   




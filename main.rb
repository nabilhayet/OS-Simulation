require './Pid.rb'
require './memory.rb'
require './parent_child.rb'
require './hard_disk.rb'
require "pry"
puts "------------------------------"
$pid = 0
$cpu = 0
$process_array = Array.new
$parent_child_process = Hash.new 
$ready_queue = Array.new 
$hard_disk_input = Array.new
$hard_disk = Hash.new
$disk_remove_input = Array.new 
$wait_quit = Hash.new
$zombie_process = Hash.new
$waiting_state_parent_zombie_process = Array.new
$process_has_parent = false 

puts "How many Hard Disks does the computer Have?"
$hard_disks_number = Integer(gets.chomp)

puts "Please enter your input"
input = gets.chomp

while(input != 'Exit')
  if(input == 'A')
    CreateProcess(input)
  elsif(input == 'Q')
    ProcessQueueAdjust()
  elsif(input == 'fork')
    CreateProcess(input)
  elsif(input == 'S r')
    ProcessStatus()
  elsif(input.match(/d{1}\s\d\s\w*.txt/))
    if($cpu <= 0)
      puts "No Process is using CPU and Hard Disk can not be Read!"
    else
      $hard_disk_input = input.split(" ")
      puts "Requesting to Read Hard Disk Number #{$hard_disk_input[1]}" 
      # hard disk number starts from zero 
      puts "File Read Request #{$hard_disk_input[2]}"
      if(Integer($hard_disk_input[1]) < $hard_disks_number)
        HardDiskRead()
      else
        puts "The Hard Disk Number You Read Request Not Valid!"
        $hard_disk_input.clear()
      end 
    end 
   
  elsif(input == 'S i')
    HardDiskStatus()
  elsif(input == 'S e')
    ShowInfo()
  elsif(input.match(/D{1}\s\d/))
    $disk_remove_input = input.split(" ")
    $disk_remove_input[1] = Integer($disk_remove_input[1])
    if($hard_disk.has_key?($disk_remove_input[1]))
      HardDiskAdjust()
    else
      puts "There is no Hard Disk being used with that number!"
      $disk_remove_input.clear()
    end 
  elsif(input == 'quit')
    RemoveProcess(input)
  elsif(input == 'wait')
    WaitParentProcess(input)
  else
    puts "Please Give a valid input"
  end 
  puts "Please enter your input"
  input = gets.chomp
end 



   




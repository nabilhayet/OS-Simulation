require './Pid.rb'
puts "------------------------------"
$pid = 0
$cpu = 0
$process_array = Array.new
$parent_child_process = Hash.new 
$ready_queue = Array.new 
$processing_waiting_queue = Array.new

puts "How many Hard Disks does the computer Have?"
$hard_disks = gets.chomp

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
  puts "The process using the cpu #{$cpu}"
  puts "The processes waitting in ready queue to use cpu are #{$ready_queue}"
end 

def ProcessQueueAdjust
if($cpu != 0)
  $ready_queue.push($cpu)
end 
$cpu = 0
$cpu = $ready_queue[0]
$ready_queue.shift()
end 

def HardDiskRead

end 

def HardDiskStatus

end 

def HardDiskAdjust

end 

def RemoveProcess

end 

def WaitParentProcess
  
end 

def FindProcessId
   puts "The Process id is #{@process.findObject}"
end 

def ShowAllProcess
  puts "The processess are #{$process_array[0]}"
end 


puts "Please enter your input"
input = gets.chomp

while(input != 'Exit')

  if(input == 'A')
    CreateProcess(input)
  elsif(input == 'Q')
    ProcessQueueAdjust()
  elsif(input == 'fork')
    CreateProcess(input)
    # ParentChildProcess()
  elsif(input == 'S r')
    ProcessStatus()
  elsif(input == 'd 0 asd.txt')
    HardDiskRead()
  elsif(input == 'S i')
    HardDiskStatus()
  elsif(input == 'D 0')
    HardDiskAdjust()
  elsif(input == 'quit')
    RemoveProcess()
  elsif(input == 'wait')
    WaitParentProcess()
  else
    puts "Please Give a valid input"
  end 
  puts "Please enter your input"
  input = gets.chomp
end 
   






require './Pid.rb'
puts "------------------------------"
$pid = 0
$cpu = 0
$process_array = Array.new
$parent_child_process = Hash.new 
$ready_queue = Array.new 

def CreateProcess
  @process =  Pid.new($pid)
  $process_array.push(@process)
  $parent_child_process[$cpu] = []
  MemoryUtilization()
end 

def MemoryUtilization
  if($ready_queue.length == 0)
    $ready_queue.push(@process.pid)
  end 
  if($cpu == 0 && $ready_queue.length > 0)
    $cpu = $ready_queue[-1]
  end
end 

def ProcessStatus
  puts "----------------------"
  puts "The process using the cpu #{$cpu}"
  puts "The processes waitting in ready queue to use cpu are #{$ready_queue}"
end 

def ParentChildProcess
  ($parent_child_process[$cpu] ||= []) << @process.findObject
  puts $parent_child_process
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
    CreateProcess()
  elsif(input == 'Q')
    MemoryUtilization()
  elsif(input == 'fork')
    ParentChildProcess()
  elsif(input == 'S r')
    ProcessStatus()
  end 
  puts "Please enter your input"
  input = gets.chomp
end 
   






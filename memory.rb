require './Pid.rb'

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

def ShowInfo
  puts "The Process using CPU IS : #{$cpu}"
  puts "The processes are #{$process_array}"
  puts "The parent child processes are #{$parent_child_process}"
  puts "The processes waiting in ready queue to use CPU are #{$ready_queue}"
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


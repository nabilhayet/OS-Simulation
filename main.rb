require './Pid.rb'
puts "------------------------------"
$pid = 0
$cpu = 0
$process_array = Array.new
$parent_child_process = Hash.new 
$ready_queue = Array.new 
$processing_waiting_queue = Array.new
$hard_disk_input = Array.new
$hard_disk = Hash.new



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

# hard disk = {
#   0: {  process: { 3: 'asd.txt'}, 
#         IOQueue: [2,6,7],
#         processQueuefile: { 2: '2we.txt'}
# }
#  hash[:foo] ||= {}
#  hash[:foo][:bar][:baz] = "hello"
#

def HardDiskRead
  puts "Hello World"
  $hard_disk_input[1] = Integer($hard_disk_input[1])
  if($hard_disk.has_key?($hard_disk_input[1])) # That means it hhas been read already
    if(($hard_disk[$hard_disk_input[1]]["process"]).empty?)
      $hard_disk[$hard_disk_input[1]]["process"][$cpu] = $hard_disk_input[2]
     
    else
      $hard_disk[$hard_disk_input[1]]["IOQueue"] << $cpu
      $hard_disk[$hard_disk_input[1]]["processqueuefile"][$cpu] = $hard_disk_input[2]
      $cpu = 0
      $cpu = $ready_queue[0]
      $ready_queue.shift()
    end 
  else
    $hard_disk[$hard_disk_input[1]] = {}
    $hard_disk[$hard_disk_input[1]]["process"] = {}
    $hard_disk[$hard_disk_input[1]]["IOQueue"] = []
    $hard_disk[$hard_disk_input[1]]["processqueuefile"] = {}
  end 

  puts $hard_disk
 
end 
 
 # $hard_disk[$hard_disk_input[1]] ||= {}
 # $hard_disk[$hard_disk_input[1]]["process"] ||= {}
 # $hard_disk[$hard_disk_input[1]]["IOQueue"] ||= []
 # $hard_disk[$hard_disk_input[1]]["processqueuefile"] ||= {}
 

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
   




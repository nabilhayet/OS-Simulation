require './Pid.rb'
puts "Please enter your name"
name = gets.chomp
puts "Hello, #{name}! I'm Ruby!"
puts "------------------------------"
$pid = 0
$cpu = 0
$process_array = Array.new
$parent_child_process = Hash.new 
$ready_queue = Array.new 


def CreateProcess
  @process =  Pid.new($pid)
  $process_array.push(@process)
  if($ready_queue.length == 0)
    $ready_queue.push(@process.pid)
  end 
  if($cpu == 0 && $ready_queue.length > 0)
    $cpu = $ready_queue[-1]
  end
end 

def FindProcessId
   puts "The Process id is #{@process.findObject}"
end 

def ShowAllProcess
  puts "The processess are #{$process_array[0]}"
end 

CreateProcess()
FindProcessId()
ShowAllProcess()
puts "----------------------"
puts "The process using the cpu #{$cpu}"
puts "The processes waitting in ready queue to use cpu are #{$ready_queue}"

puts "Please enter your input"
input = gets.chomp

if(input == 'A')
  puts $cpu
  $parent_child_process[$cpu] = []
else
  ($parent_child_process[$cpu] ||= []) << @process.findObject
end 

puts $parent_child_process





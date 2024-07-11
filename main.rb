require './Pid.rb'
puts "Please enter your name"
name = gets.chomp
puts "Hello, #{name}! I'm Ruby!"
$pid = 0
$cpu = 0
$process_array = Array.new


def CreateProcess
  @process =  Pid.new($pid)
  $process_array.push(@process)
 
end 

def FindProcessId
   puts "The Process id is #{@process.findObject}"
end 

def ShowAllProcess
  puts $process_array[0].pid
end 

CreateProcess()
FindProcessId()
ShowAllProcess()



require './hard_disk.rb'

def RemoveProcess(input)
  puts "-----------------------"
  puts "I am inside Remove Process"
  $wait_quit[$cpu] = input
  parent_process = nil 

  if($cpu != 0)
    $parent_child_process.each do |parent,child| 
      if(parent == $cpu)
        $ready_queue.delete_if {|item| $parent_child_process[$cpu].include?(item) }
        RemoveProcessFromHardDisk(parent)
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

  if($process_has_parent == true)
    if($wait_quit[parent_process] == 'wait')
      $parent_child_process.delete($cpu)
      $parent_child_process[parent_process].delete($cpu)
      $wait_quit.delete($cpu)
      $wait_quit.delete(parent_process)
      $ready_queue.push(parent_process)
      $waiting_state_parent_zombie_process.delete(parent_process)
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

  if(!$parent_child_process[$cpu] || $parent_child_process[$cpu].length == 0)
    puts "No need to wait, the process can continue as it has no child"
    $wait_quit.delete($cpu)
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

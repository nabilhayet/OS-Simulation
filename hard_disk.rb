def HardDiskRead
  puts "Hello World"
  $hard_disk_input[1] = Integer($hard_disk_input[1])

  if(!$hard_disk.has_key?($hard_disk_input[1]))
    $hard_disk[$hard_disk_input[1]] = {}
    $hard_disk[$hard_disk_input[1]]["process"] = {}
    $hard_disk[$hard_disk_input[1]]["IOQueue"] = []
    $hard_disk[$hard_disk_input[1]]["processqueuefile"] = {}
  end 

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

def RemoveProcessFromHardDisk(input)
  puts "I am inside Hard disk Remove Processs"
  $hard_disk.each do |key,value|
    value.each do |name, process|
      if(name == 'IOQueue' && $hard_disk[key][name].any?{ |i|  $parent_child_process[input].include?(i)})
          $hard_disk[key][name].delete_if {|item| $parent_child_process[input].include?(item)}
          $hard_disk[key]["processqueuefile"].delete_if {|item| $parent_child_process[input].include?(item)}
      end 
      if(name == 'process' && ($parent_child_process[input]).include?($hard_disk[key][name].keys.first))
        $hard_disk[key][name].clear()
      end 
    end 
  end 

  $hard_disk.each do |number,disks|
    if($hard_disk[number]["process"].empty?)
      if($hard_disk[number]["IOQueue"].length > 0)
        a = $hard_disk[number]["IOQueue"][0]
        b = $hard_disk[number]["processqueuefile"][a]
        $hard_disk[number]["process"][a] = b 
        $hard_disk[number]["processqueuefile"].delete(a)
        $hard_disk[number]["IOQueue"].shift()
      end 
    end 
  end 
end 
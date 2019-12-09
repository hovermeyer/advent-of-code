file_data = File.read("input.txt").split

fuel_per_module = file_data.map{|x| (x.to_i / 3-2).floor}

puts fuel_per_module.sum

def fuel_required(module_weight)
  marginal_weight = (module_weight / 3 -2).floor
  fuel = 0
  while marginal_weight > 0
    fuel +=marginal_weight
    marginal_weight = (marginal_weight / 3 -2).floor
  end
  fuel
end

file_data = File.read("input.txt").split

fuel_per_module = file_data.map{|x| fuel_required(x.to_i)}

puts fuel_per_module.sum

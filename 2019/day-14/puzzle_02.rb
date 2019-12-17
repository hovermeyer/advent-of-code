file_data = File.read("input.txt").split("\n")


file_data = file_data.map{|row| row.split("=>")}.map{|row| row.reverse}

file_data = file_data.map{|row| [row[0].scan(/\w+/).reverse, row[1].scan(/\w+/).reverse] }
file_data = file_data.map{|row| [row[0][0],[row[0][1].to_i,Hash[row[1].each_slice(2).to_a]]]}
file_data = file_data.to_h

goal = {"FUEL":1}
bank = Hash.new(0)

def get_previous_state(current, formulae, bank)
  previous_state = Hash.new(0)
  current.each{|ingredient, amount|
    if ingredient == "ORE"
      previous_state["ORE"] += amount
    else
      formula = formulae[ingredient.to_s]
      banked  = bank[ingredient.to_s]
      #puts "amount #{amount - bank[ingredient.to_s]} formula makes #{formula[0]}"
      times = ((amount.to_f - banked)/formula[0].to_f ).ceil

      if times > 0 then
        leftover = formula[0]*times - amount + banked
        bank[ingredient.to_s] = leftover
        formula[1].each{|key,value|
          previous_state[key] += value.to_i*times
        }
      else
        bank[ingredient.to_s] -= amount
        if bank[ingredient.to_s] <0 then
          puts "some issue here"
        end
      end

  end
  }
  [previous_state, bank]
end

def ore_required(goal, formulae,bank)
  current,bank = get_previous_state(goal, formulae,bank)
  while current.length > 1
    current,bank = get_previous_state(current, formulae,bank)
  end
  current["ORE"]
end

def find_total(available_ore, file_data, bank)
  i =1
  ore_cost = ore_required({"FUEL":i}, file_data, bank.dup)
  while ore_cost <available_ore
    puts "#{i}: #{ore_cost}"
    if (available_ore.to_f/ore_cost.to_f <1.1) then #once we are getting close stop and only add one each time
      i +=1
    else
      i = i* available_ore/ore_cost
    end
    ore_cost = ore_required({"FUEL":i}, file_data, bank.dup)
  end
  return i-1
end

puts find_total(1000000000000, file_data, bank)

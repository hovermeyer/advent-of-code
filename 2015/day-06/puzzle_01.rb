file_data = File.read("input.txt").split("\n")

instructions = file_data.map{|row| row.scan(/\d+|\bt[a-zA-Z]+\s?[a-zA-Z]+/)}

lights = Array.new(1000) { Array.new(1000,0) }

def turn_on(x1,y1, x2, y2, lights)
  for x in (x1..x2)
    for y in (y1..y2)
      lights[x][y] = 1
    end
  end
end

def turn_off(x1,y1, x2, y2, lights)
  for x in (x1..x2)
    for y in (y1..y2)
      lights[x][y] = 0
    end
  end
end

def toggle(x1,y1, x2, y2, lights)
  for x in (x1..x2)
    for y in (y1..y2)
      if lights[x][y] == 0 then
        lights[x][y] = 1
      else
        lights[x][y] = 0
      end
    end
  end
end


instructions.each{|instruction|
  type = instruction[0]
  x1 = instruction[1].to_i
  y1 = instruction[2].to_i
  x2 = instruction[4].to_i
  y2 = instruction[5].to_i
  case type
    when "turn on"
      turn_on(x1, y1, x2,y2, lights)
    when "turn off"
      turn_off(x1, y1, x2,y2,lights)
    when "toggle"
      toggle(x1,y1,x2,y2, lights)
    else
      puts "hit an error"
  end
  puts "type #{type} #{x1},#{y1} to #{x2},#{y2}"
  puts lights.map{|row| row.sum}.sum

}

puts lights.map{|row| row.sum}.sum

input_data = File.read("input.txt").split

wire1 = input_data[0].split(",")
wire2 =input_data[1].split(",")
#basic idea - let's call the central point 0, 0  - this makes it easiest to identify the manhattan distance
#process each wire, get sets of coordinates as required
#compare the wires together, looking for the smallest sum of coordiates that exist in both

def cells_with_wire(wire)
  grid = []
  current_x = 0
  current_y = 0
  for i in (0..wire.length-1) #split is getting one extra blank field for some reason?
    direction = wire[i].slice(0)
    steps = wire[i].slice(1,10).to_i
    case direction
      when "R"
        #going right, keep y digit, increase x
        grid += ((1...steps).map{|x| [current_x + x, current_y]})
        current_x += steps
      when "L"
        #going left, keep y, decrease x
        grid += ((1...steps).map{|x| [current_x - x, current_y]})
        current_x -= steps
      when "U"
        #going up, keep x, increase y
        grid += ((1...steps).map{|y| [current_x, current_y+y]})
        current_y += steps

      when "D"
        #going down, keep  x, decrease y
        grid += ((1...steps).map{|y| [current_x, current_y-y]})
        current_y -= steps
      else
        puts "Error #{instruction} does not make sense"
        break
    end
  end
  grid
end

def smallest_distance_manhattan(wire1,wire2)
  wire1_grid = cells_with_wire(wire1)
  wire2_grid = cells_with_wire(wire2)

  shared = wire1_grid & wire2_grid

  shared.min{|x,y| x[0].abs+x[1].abs <=>y[0].abs+y[1].abs}.sum


end

print smallest_distance_manhattan(wire1,wire2)

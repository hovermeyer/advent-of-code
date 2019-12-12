
initial_position = "<x=13, y=-13, z=-2>
<x=16, y=2, z=-15>
<x=7, y=-18, z=-12>
<x=-3, y=-8, z=-8>"

positions= initial_position.lines.map{|row| row.scan(/-?\d+/).map{|a| a.to_i}}.transpose

def step_single_coord(coord_position_and_velocity)
  #I am being provided something in the format[[x1,x2,x3,x4],[v1,v2,v3,v4]]
  positions = coord_position_and_velocity[0]
  change = positions.map{|a| positions.count{|b| a<b} - positions.count{|b| a>b}}
  velocity = change.zip(coord_position_and_velocity[1]).map{|row| row[0]+ row[1]}
  [positions.zip(velocity).map{|row| row[0]+ row[1]}, velocity]
end

def find_repeat_condition(initial_positions)
  positions = [initial_positions,[0,0,0,0]]
  total_position = []
  new_position = positions
  i =0
  temp =[]
  differences = [positions[0][1]-positions[0][0], positions[0][2]-positions[0][1],positions[0][3]-positions[0][2]]
  #the orbit needs to hit the point where it is still to begin coming back, and the total will always be twice that.
  while temp != differences
    temp = differences
    total_position.push(new_position)
    i+=1
    new_position = step_single_coord(new_position)
    differences = [new_position[0][1]-new_position[0][0], new_position[0][2]-new_position[0][1],new_position[0][3]-new_position[0][2]]
  end
  total_position.length
end

find_repeat_condition([0,-3,3,10])

def find_total_repeat(positions)

  x_repeat = find_repeat_condition(positions[0])*2
  y_repeat = find_repeat_condition(positions[1])*2
  z_repeat = find_repeat_condition(positions[2])*2
  puts "x: #{x_repeat}"
  puts "y: #{y_repeat}"
  puts "z: #{z_repeat}"
  repeat = z_repeat.lcm(y_repeat).lcm(x_repeat)
end


puts find_total_repeat(positions)

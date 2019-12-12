
initial_position = "<x=13, y=-13, z=-2>
<x=16, y=2, z=-15>
<x=7, y=-18, z=-12>
<x=-3, y=-8, z=-8>"

positions_and_velocities = initial_position.lines.map{|row| [row.scan(/-?\d+/).map{|a| a.to_i},[0,0,0]]}
moon_pairs = (0..3).to_a.repeated_combination(2).filter{|x| x[0] != x[1]}


def gravity(positions_and_velocities, moon_pair)
  moon1 = positions_and_velocities[moon_pair[0]]
  moon2 = positions_and_velocities[moon_pair[1]]
  change = coordinate_change(moon1[0],moon2[0])
  moon1[1] = moon1[1].zip(change[0]).map{|row| row[0]+ row[1]}
  moon2[1] = moon2[1].zip(change[1]).map{|row| row[0]+ row[1]}
end

def coordinate_change(a,b)
  change = [[0,0,0],[0,0,0]]
  for i in (0...3)
    if a[i]<b[i] then
      change[0][i] = 1
      change[1][i] = -1
    elsif a[i]>b[i] then
      change[0][i] = -1
      change[1][i] = 1
    end
  end
  change
end


for i in (1..1000)
  puts "step #{i}"
  #apply gravity
  moon_pairs.each{|pair|
    gravity(positions_and_velocities, pair)
  }

  #update position
  positions_and_velocities.map!{|moon| [moon[0].zip(moon[1]).map{|row| row[0]+ row[1]}, moon[1]]}

  puts "positions_and_velocities after  : #{positions_and_velocities}"

end

energy = positions_and_velocities.map{|moon| moon[0].map{|x| x.abs}.sum * moon[1].map{|x| x.abs}.sum}.sum

puts energy

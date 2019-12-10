file_data = File.read("input.txt").split
input = file_data.map{|x| x.split(")")}

def get_next_level(current_level, orbit_pairs)
  next_level = orbit_pairs.filter{|x| ([x[0]] & current_level) == [x[0]]}
  orbit_pairs.delete_if{|x| ([x[0]] & current_level) == [x[0]]}
  next_level.map{|x| x[1]}
end

def get_orbit_levels(input)
  orbits = [['COM']]
  orbit_pairs = input.dup
  i=0
  while orbit_pairs.length>0
    orbits.push(get_next_level(orbits[i],orbit_pairs))
    i+=1
  end

  counter = 0
  for i in (0..orbits.length-1)
    counter += orbits[i].length*i
  end

  puts counter
end

def get_orbitting(input, search_item)
  input.filter{|x| x[1] == search_item}[0][0]
end

def get_orbit_path(input, search_item)
    orbit_path = []
    orbit_pairs = input.dup
    previous = get_orbitting(orbit_pairs,search_item)
    while previous != "COM"
      orbit_path.push(previous)
      previous = get_orbitting(orbit_pairs,previous)
    end
    orbit_path
end

def find_transfers(input, start, goal)
  start_path = get_orbit_path(input, start)
  goal_path  = get_orbit_path(input, goal)
  shared = start_path & goal_path

  start_path.length + goal_path.length - shared.length*2
end

print find_transfers(input, "YOU","SAN")

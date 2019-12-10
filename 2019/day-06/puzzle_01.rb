file_data = File.read("input.txt").split
orbit_pairs = file_data.map{|x| x.split(")")}


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

get_orbit_levels(orbit_pairs)

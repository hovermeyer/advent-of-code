file_data = File.read("input.txt").split.map{|x| x.scan(/./)}

def array_to_coords(input)
  coordinates = []
  for i in (0...input.length)
    for j in (0...input[i].length)
      if input[i][j] == "#" then
        coordinates.push([i,j])
      end
    end
  end
  coordinates
end

coordinates = array_to_coords(file_data)

#my idea:  try using slopes to create groupings of asteroids that can't be seen

#find list of coordinates with asteroids
#find the slope of the line (x1-x)/(y1-y)
#encode slope need to know if (+,+ vs -,- and +, - vs -+).  So slope, and
#get total unique slope+ direction combos, that will be the number it can see

def relative_location(location, x, y)
  x1 = location[0]
  y1 = location[1]

  #puts "(#{x1} - #{x})/(#{y1} - #{y}) = #{Rational((x1-x),(y1-y))}"
  if y1 == y then
    ["undefined", x1 <= x]
  elsif x1 == x then
    [Rational((x1-x),(y1-y)), y1 <= y]
  else
    [Rational((x1-x),(y1-y)), x1 <= x]
  end
end


def find_asteroid_visible(input, x, y)
  input.map{|coord| relative_location(coord,x,y)}
end

def find_best(input)
  input.map{|row| [row, find_asteroid_visible(input, row[0], row[1]).uniq.length]}.max{|a,b| a[1]<=>b[1]}
end


print(find_asteroid_visible(coordinates, 22,2))

puts "final_result"
print(find_best(coordinates))

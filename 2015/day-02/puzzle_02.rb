file_data = File.read("input.txt").split.map{|row| row.split("x").map(&:to_i).sort}
#doing the sort on dimensionsfirst to get the smallest side area as l*w


def required_paper(dimensions)
  l = dimensions[0]
  w = dimensions[1]
  h = dimensions[2]
  3*l*w + 2*w*h + 2*h*l
end

def required_ribbon(dimensions)
  l = dimensions[0]
  w = dimensions[1]
  h = dimensions[2]
  2*(l+w) + l*w*h
end


required = file_data.map{|present| required_ribbon(present)}

print required.sum

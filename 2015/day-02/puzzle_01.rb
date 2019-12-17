file_data = File.read("input.txt").split.map{|row| row.split("x").map(&:to_i).sort}
#doing the sort on dimensionsfirst to get the smallest side area as l*w


def required_paper(dimensions)
  l = dimensions[0]
  w = dimensions[1]
  h = dimensions[2]
  3*l*w + 2*w*h + 2*h*l
end


required = file_data.map{|present| required_paper(present)}

print required.sum

file_data = File.read("input.txt")

layers = file_data.scan(/\w{150}/).min{|x,y| x.chars.count("0")<=>y.chars.count("0")}
puts layers
puts layers.chars.count("1") * layers.chars.count("2")

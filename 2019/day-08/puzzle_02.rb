file_data = File.read("input.txt")

layers = file_data.scan(/\w{150}/).map{|x| x.scan(/\w/)}

COLOUR = [" ","X"]
transparency = ["2"]*150
for i in (0...layers.length)
  transparency= transparency.zip(layers[i]).map{|x| (if x[0] == "2" then x[1] else x[0] end) }
end


puts transparency.map{|x| COLOUR[x.to_i]}.join().scan(/.{25}/)

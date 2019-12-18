file_data = File.read("input.txt").split


def naughty_or_nice(word)

  one_letter_seperate= word.chars.each_cons(3).map{|row| row[0] == row[2]}.count(true) > 0

  duplicate_but_not_overlapping = word.scan(/\w*(..)\w*\1/).length >=1


  puts "#{word} has one_letter_seperate #{one_letter_seperate}  and duplicate_but_not_overlapping #{duplicate_but_not_overlapping}"
  one_letter_seperate  && duplicate_but_not_overlapping
end

puts file_data.map{|word| naughty_or_nice(word)}.count(true)

file_data = File.read("input.txt").split


def naughty_or_nice(word)
  three_vowels = word.scan(/[aeiou]/).length >=3
  no_banned_words = word.scan(/ab|cd|pq|xy/).length == 0
  duplicate_letter = word.scan(/((.)\2)/).length >=1

  #puts "#{word} has three_vowels #{three_vowels} no_banned_words: #{no_banned_words} and duplicate_letter #{duplicate_letter}"
  three_vowels && no_banned_words && duplicate_letter
end

puts file_data.map{|word| naughty_or_nice(word)}.count(true)

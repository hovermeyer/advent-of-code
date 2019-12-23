file_data = File.read("input.txt").split("\n")

file_data.map!{|row| row.scan(/-*\d+|\b[a-zA-Z]+\s?[a-zA-Z]+/)}


deck = (0..10006).to_a

def cut(deck, amount)
  puts "calling cut #{amount}"
  if amount < 0 then
    #take amount off the end
    temp = deck.pop(amount.abs)
    puts "Temp is #{temp}"
    deck = temp + deck
    puts "final deck is #{deck}"
  else
    #take amount off the front
    temp = deck.shift(amount)
    deck = deck + temp
  end
  deck
end

def increment(deck, amount)
  deck_size = deck.length
  temp_deck = deck.dup
  i =0
  j = 0
  while i < deck_size
    deck[j] = temp_deck[i]
    i += 1
    j = (j + amount) % deck_size
  end
  deck
end


def process_shuffle(instructions, deck)
  instructions.each{|instruction|
    type = instruction[0]
    case type
    when "deal into"
      deck.reverse!
    when "deal with"
      deck = increment(deck, instruction[2].to_i)
    when "cut"
      deck = cut(deck, instruction[1].to_i)
    end
  }
  puts "final deck #{deck} and #{deck.find_index(2019)}"
end

process_shuffle(file_data, deck)

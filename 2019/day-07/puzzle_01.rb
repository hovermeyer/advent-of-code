puzzle_input = [3,8,1001,8,10,8,105,1,0,0,21,38,63,80,105,118,199,280,361,442,99999,3,9,102,5,9,9,1001,9,3,9,1002,9,2,9,4,9,99,3,9,1001,
  9,4,9,102,4,9,9,101,4,9,9,102,2,9,9,101,2,9,9,4,9,99,3,9,1001,9,5,9,102,4,9,9,1001,9,4,9,4,9,99,3,9,101,3,9,9,1002,9,5,9,
  101,3,9,9,102,5,9,9,101,3,9,9,4,9,99,3,9,1002,9,2,9,1001,9,4,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,
  9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,
  4,9,3,9,1001,9,1,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,
  4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,101,1,9,9,
  4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,
  9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,
  9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,
  3,9,1001,9,1,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,
  3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,99]


def read_intcode(input, initial_phase)
  size = input.length
  i = 0
  j=0
  while i < size
    parameter_modes = input[i].digits
    while parameter_modes.length < 5
      parameter_modes.push(0)
    end
    opcode = parameter_modes[0] + 10 * parameter_modes[1]
    #puts "#{i} is #{input[i]} which became #{opcode}"

    parameters =  {1 => (if parameter_modes[2] == 0 then input[i+1] else i+1 end) ,
                  2  => (if parameter_modes[3] == 0 then input[i+2] else i+2 end),
                  3  => (if parameter_modes[4] == 0 then input[i+3] else i+3 end)}

    case opcode
      when 99
        break
      when 1
        input[parameters[3]] = input[parameters[2]] + input[parameters[1]]
        i+=4
      when 2
        input[parameters[3]] = input[parameters[2]] * input[parameters[1]]
        i+=4
      when 3
        input[parameters[1]] = initial_phase[j]
        j+=1
        i+=2
      when 4
        return input[parameters[1]]
        i+=2
      when 5
        if input[parameters[1]] != 0 then
          i = input[parameters[2]]
        else
          i+=3
        end
      when 6
        if input[parameters[1]] == 0 then
          i = input[parameters[2]]
        else
          i+=3
        end
      when 7
        if input[parameters[1]] < input[parameters[2]] then
          input[parameters[3]]=1
        else
          input[parameters[3]]=0
        end
        i+=4
      when 8
        if input[parameters[1]] == input[parameters[2]] then
          input[parameters[3]]=1
        else
          input[parameters[3]]=0
        end
        i+=4
      else
        puts "Error: hit unexpected opcode(#{input[i]})"
        break
      end
  end
  input
end


def get_all_amplifier_settings(number)
  (0..number).to_a.permutation.to_a
end

def get_result_amplifier_settings(input, amplifier_setting)
  result = 0
  for i in (0...amplifier_setting.length )
    result = read_intcode(input.dup,[amplifier_setting[i], result])
  end
  result

end

def get_max_amplifier_setting(input,number)
  settings = get_all_amplifier_settings(number)
  settings.map{|x| [x, get_result_amplifier_settings(input, x)]}.max{|x,y| x[1]<=>y[1]}

end

puts get_result_amplifier_settings(puzzle_input, [0,1,2,3,4])
print get_max_amplifier_setting(puzzle_input,4)

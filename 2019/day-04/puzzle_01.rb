

def valid_password?(password)
  non_decreasing = (password[0]<= password[1]) && (password[1] <= password[2]) && (password[2] <= password[3]) && (password[3] <= password[4]) && (password[4] <= password[5])
  consecutive = password[0] == password[1] || password[1] == password[2] || password[2] == password[3] || password[3] == password[4] || password[4] == password[5]
  consecutive && non_decreasing
end

print (387638..919123).filter{|password| valid_password?(password.to_s.chars)}.length

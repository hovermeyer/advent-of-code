
def valid_password?(password)
  non_decreasing = (password[0]<= password[1]) && (password[1] <= password[2]) && (password[2] <= password[3]) && (password[3] <= password[4]) && (password[4] <= password[5])
  consecutive =  (0..9).filter{|i| password.index(i.to_s + i.to_s) !=nil && password.index(i.to_s + i.to_s + i.to_s) == nil}.length >0
  consecutive && non_decreasing
end

print (387638..919123).filter{|password| valid_password?(password.to_s)}.length

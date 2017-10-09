# In the following 6 digit number:
#
# 283910
# 91 is the greatest sequence of 2 digits.
#
# In the following 10 digit number:
#
# 1234567890
# 67890 is the greatest sequence of 5 digits.
#
# Complete the solution so that it returns the largest five digit number
# found within the number given. The number will be passed in as a string
# of only digits. It should return a five digit integer.
# The number passed may be as large as 1000 digits.
#

# Brute force (slices of 5)
def solution(digits)
  max = -Float::INFINITY

  (0..digits.size - 5).each do |i|
    max = digits[i...i + 5].to_i if digits[i...i + 5].to_i > max
  end

  max
end

p solution("12345678909125") # 90912

def solution(digits, length = 5)
  max = 0
  max_check = digits.size - length

  (0..max_check).each do |i|
    max = digits[i...i + length].to_i if digits[i...i + length].to_i > max
  end

  max
end

p solution("12345678909125") # 90912

# Brute force (each_cons)
# Note that `max` can compare the strings (by their unicode val probably?)
## be careful with this in other problems:
## ["9214", "90444"].max for example would pick 9214
# O(n) worst-case because of .max?
def solution(digits)
  digits.split("").each_cons(5).max.join.to_i
end

p solution("12345678909125") # 90912

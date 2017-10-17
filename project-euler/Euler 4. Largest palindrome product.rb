# A palindromic number reads the same both ways.
# The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.

# 1 possible solution: we could start making palindromes down from 999*999
# and check if they have two 3 digit factors (maybe via quadratic formula?)
# ..the first that does have two 3 digit factors would be our answer

# optimize brute force
def largest_palindrome(k)
  max_palindrome = -Float::INFINITY
  max_k_digit = 10**k - 1

  max_k_digit.downto(100) do |i|
    max_k_digit.downto(100) do |j|
      if palindrome?(i * j)
        max_palindrome = i * j
        break
      end

      break if i * j < max_palindrome
    end
  end

  max_palindrome
end

def palindrome?(number)
  number.to_s == number.to_s.reverse
end

p largest_palindrome(3) # => 906609

# alternative method
# you can use % 10 to get the last digit(s)
# then left adjust the number by a 0 (*= 10)
# then adjust the input number. repeat till input is 0
# e.g. palindrome?(505)
# 0 *= 10 -> p is 0, 0 += 5 -> p is 5, 505 /= 10 -> n is 50
# 5 *= 10 -> p is 50, 50 += 0 -> p is 50, 50 /= 10 -> n is 5
# 50 *= 10 -> p is 500, 500 += 5 -> p is 505, 5 /= 10 -> n is 10. exit loop.
# i.e. we go from 505 to 500 & 5 to 50 & 50 to 5 and 500 back to 505.
def palindrome?(number)
  n = number
  palindrome = 0

  until n.zero?
    palindrome *= 10
    palindrome += n % 10
    n /= 10
  end

  palindrome == number
end

p largest_palindrome(3) # => 906609

# brute force
def largest_palindrome(k)
  max = -1

  (10**(k - 1)...10**k).each do |n1|
    (10**(k - 1)...10**k).each do |n2|
      max = n1 * n2 if max < n1 * n2 && palindrome?(n1 * n2)
    end
  end

  max
end

def palindrome?(number)
  number.to_s == number.to_s.reverse
end

p largest_palindrome(3) # => 906609

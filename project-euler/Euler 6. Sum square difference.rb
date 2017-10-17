# The sum of the squares of the first ten natural numbers is,
# 1**2 + 2**2 + ... + 10**2 = 385
#
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)**2 = 552 = 3025
#
# Hence the difference between the sum of the squares of the
# first ten natural numbers and the square of the
# sum is 3025 − 385 = 2640.
#
# Find the difference between the sum of the squares of the
# first one hundred natural numbers and the square of the sum.

def sum_of_squares_diff(n)
  exp2 = ->(x) { x**2 }
  (1..n).reduce(:+)**2 - (1..n).map(&exp2).reduce(:+)
end

p sum_of_squares_diff(100)

# brute force
def sum_of_squares_diff(n)
  sum_of_squares = 0
  (1..n).each { |num| sum_of_squares += num**2 }

  (1..n).reduce(:+)**2 - sum_of_squares
end

p sum_of_squares_diff(100)

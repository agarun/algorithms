# 2520 is the smallest number that can be divided by
# each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly
# divisible by all of the numbers from 1 to 20?

# method (3)
# compiling a hash of unique prime factors of all the factors,
# where we only add the 'max' # prime numbers a particular number might have,
# this should in turn gather all the prime factors of our target 'smallest pos number'
# such that multiplying them..yields the number!

# method (2)
# recursive
#
# this is based on how in method (1) i incremented n by 20. we can actually
# increment by much larger numbers
# If we are looking for the 'smallest positive number that is evenly divisible by
# all the numbers from 1 to 20', we can increment at that level by the
# 'smallest positive number that is evenly divisible by all .. from 1 to 19'
# similarly we can repeat this at 19,
# we can recursively determine what numbers to increment by
# our base case will return '1' when we check 1, and then we can start building
# up the 'increment' values by returning from recursions

# e.g. smallest_div(6)
# we want to increment by smallest_div(5) until we have the valid condition
## (that is, increment by a num "evenly divisible by all the nums from 1 to 5")
# -> smallest_div(5) -> smallest_div(4) -> .. -> smallest_div(1) returns 1
# then smallest_div(2) increments by 1 and returns 2
# then smallest_div(3) increments by 2 and returns 6 (note 6 is the first number
# from 0 to 6 that satisfies the condition quoted above)
# then smallest_div(4) increments by 6 and returns 12
# then smallest_div(5) increments by 12 and returns 60
## (note from above, it returns a num "evenly divisible by all the nums from 1 to 5")
# lastly, smallest_div(6) increments 0 by 60 and returns 60
def smallest_div(n)
  # base case
  return 1 if n == 1

  increment = smallest_div(n - 1)

  # until multiple is evenly divisible by all numbers from 1 to multiple
  # we increment by the 'step' number that was returned.
  # this is done because our 'increment' must satisfy the condition up to its `n`
  multiple = 0

  until multiple > 0 && (1..n).all? { |i| multiple % i == 0 }
    multiple += increment
  end

  multiple
end

p smallest_div(20) # => 232792560

# method (1)
# brute force
# simple ideas to optimize:
# 1 - change `(1..20)` to a predefined array
# because checking 2, 3, 4, 6 is senseless since we're also checking 12..
# 2 - implement divisibility rules to skip over numbers based on their units digit
def smallest_div(n = 20)
  while true
    return n if (2..20).all? { |i| n % i == 0 }
    n += 20
  end
end

# p smallest_div # => 232792560

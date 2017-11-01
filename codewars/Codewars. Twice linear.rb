# https://www.codewars.com/kata/twice-linear/ruby
#
# Consider a sequence u where u is defined as follows:
#
# The number u(0) = 1 is the first one in u.
# For each x in u, then y = 2 * x + 1 and z = 3 * x + 1 must be in u too.
# There are no other numbers in u.
# Ex: u = [1, 3, 4, 7, 9, 10, 13, 15, 19, 21, 22, 27, ...]
#
# 1 gives 3 and 4, then 3 gives 7 and 10, 4 gives 9 and 13, then 7 gives 15
# and 22 and so on...
#
# Task: Given parameter n the function dbl_linear (or dblLinear...)
# returns the element u(n) of the ordered (with <) sequence u.
#
#Example: dbl_linear(10) should return 22

def dbl_linear(n)
  result = [1] # base

  i = 0 # pointer for 2x + 1
  j = 0 # pointer for 3x + 1

  until result.size == n + 1 # because n is an index (size - 1)
    list1 = 2 * result[i] + 1
    list2 = 3 * result[j] + 1
    min = [list1, list2].min

    result << min

    i += 1 if min == list1
    j += 1 if min == list2
  end

  result.last
end

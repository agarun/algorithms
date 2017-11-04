# Given a positive integral number n, return a strictly increasing
# sequence (list/array/string depending on the language) of numbers,
# so that the sum of the squares is equal to n².
#
# If there are multiple solutions (and there will be),
# return the result with the largest possible values:
#
# Examples
#
# decompose(11) must return [1,2,4,10]. Note that there are actually
# two ways to decompose 11², 11² = 121 = 1 + 4 + 16 + 100 = 1² + 2² + 4² + 10²
# but don't return [2,6,9], since 9 is smaller than 10.
#
# For decompose(50) don't return [1, 1, 4, 9, 49] but [1, 3, 5, 8, 49]
# since [1, 1, 4, 9, 49] doesn't form a strictly increasing sequence.
#
# Note
#
# Neither [n] nor [1,1,1,…,1] are valid solutions.
# If no valid solution exists, return nil
#
# The function "decompose" will take a positive integer n and
# return the decomposition of N = n² as:
#
# [x1 ... xk]
#
# Hint
# Very often xk will be n-1.

# Backtracking problem
# https://en.wikipedia.org/wiki/Backtracking
# https://en.wikipedia.org/wiki/Backtracking#Pseudocode
# https://www3.cs.stonybrook.edu/~algorith/video-lectures/2007/lecture15.pdf

# "At each step in the backtracking algorithm, we start from
# a given partial solution, say, a = (a1, a2, ..., ak), and try to
# extend it by adding another element at the end.
# After extending it, we must test whether what we have so far
# is a solution.
# If not, we must then check whether the partial solution is still
# **potentially extendible** to some complete solution.
# If so, recur and continue. If not, we delete the last element
# from a and try another possibility for that position, if one
# exists."
# - Skiena lecture 15

def decompose(n)
  decomposer(n, n**2)
end

def decomposer(number, target)
  # first element added to the final sequence on the last backtrace (when target == 0)
  return [number] if target == 0

  # recursing downwards from `number - 1` chooses the 'largest possible values' if
  # the number `i` is a valid member of the possible sequence (`if target - i**2 >= 0`)
  (number - 1).downto(1) do |i|
    sequence = decomposer(i, target - i**2) if target - i**2 >= 0

    unless sequence.nil?
      # the last backtrace will consider the number itself because `decompose` calls
      # decomposer with `n`. it must not be a part of the final sequence (`unless ...`)
      sequence << number unless number**2 == target
      return sequence
    end
  end

  nil
end

p decompose(50) # => [1, 3, 5, 8, 49]
p decompose(11) # => [1, 2, 4, 10]

# 2 - show conditions more clearly
def decompose(n)
  decomposer(n, n**2)
end

def decomposer(n, target)
  # invalid conditions (can't be member of result)
  return nil if n <= 0 || target < 0

  # check nil first (above), else recursion would loop forever
  return [] if target == 0

  # try every possibility for n until accepting one where `target - n**2 is > 0`
  # (first return ensures we keep iterating valid n). if < 0, 1st return gives nil
  # and the 3rd return is never reached. if == 0, we need to return []
  # to know we reached a valid solution and return to `decompose`
  while n >= 0
    n -= 1
    sequence = decomposer(n, target - n**2)

    # exit recursion, inner recurses exit first (so it's in ascending order)
    return sequence << n unless sequence.nil?
  end

  # if while loop is exhausted (backtracking is used to iterate through all
  # subsets or permutations of a set), return nil to `decompose`
  nil
end

p decompose(50) # => [1, 3, 5, 8, 49]
p decompose(11) # => [1, 2, 4, 10]

# e.g. for decompose(50)
# "backtrack? 50" <--------------- entering/exiting recursion
# "backtrack? 49" <---------------
# "n, target-n**2: [48, -2205]"
# "n, target-n**2: [47, -2110]"
# "n, target-n**2: [46, -2017]"
# "n, target-n**2: [45, -1926]"
# "n, target-n**2: [44, -1837]"
# "n, target-n**2: [43, -1750]"
# "n, target-n**2: [42, -1665]"
# "n, target-n**2: [41, -1582]"
# "n, target-n**2: [40, -1501]"
# "n, target-n**2: [39, -1422]"
# "n, target-n**2: [38, -1345]"
# "n, target-n**2: [37, -1270]"
# "n, target-n**2: [36, -1197]"
# "n, target-n**2: [35, -1126]"
# "n, target-n**2: [34, -1057]"
# "n, target-n**2: [33, -990]"
# "n, target-n**2: [32, -925]"
# "n, target-n**2: [31, -862]"
# "n, target-n**2: [30, -801]"
# "n, target-n**2: [29, -742]"
# "n, target-n**2: [28, -685]"
# "n, target-n**2: [27, -630]"
# "n, target-n**2: [26, -577]"
# "n, target-n**2: [25, -526]"
# "n, target-n**2: [24, -477]"
# "n, target-n**2: [23, -430]"
# "n, target-n**2: [22, -385]"
# "n, target-n**2: [21, -342]"
# "n, target-n**2: [20, -301]"
# "n, target-n**2: [19, -262]"
# "n, target-n**2: [18, -225]"
# "n, target-n**2: [17, -190]"
# "n, target-n**2: [16, -157]"
# "n, target-n**2: [15, -126]"
# "n, target-n**2: [14, -97]"
# "n, target-n**2: [13, -70]"
# "n, target-n**2: [12, -45]"
# "n, target-n**2: [11, -22]"
# "n, target-n**2: [10, -1]"
# "backtrack? 9"
# "n, target-n**2: [8, -46]"
# "n, target-n**2: [7, -31]"
# "n, target-n**2: [6, -18]"
# "n, target-n**2: [5, -7]"
# "backtrack? 4"
# "n, target-n**2: [3, -7]"
# "n, target-n**2: [2, -2]"    vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# "backtrack? 1" <---- [1, 1, 4, 9, 49] is a soln, but we dont want to see 1 twice (not ascending)
# "n, target-n**2: [0, 1]"     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# "n, target-n**2: [-1, 0]"
# "n, target-n**2: [1, 1]"
# "n, target-n**2: [0, 2]"
# "n, target-n**2: [-1, 1]"
# "n, target-n**2: [4, 2]"
# "backtrack? 3" <----------- therefore we backtrack from 4 again
# "backtrack? 2"
# "backtrack? 1"
# "n, target-n**2: [0, 4]"
# "n, target-n**2: [-1, 3]"
# "n, target-n**2: [1, 4]"
# "n, target-n**2: [0, 5]"
# "n, target-n**2: [-1, 4]"
# "n, target-n**2: [2, 5]"
# "backtrack? 1"
# "n, target-n**2: [0, 8]"
# "n, target-n**2: [-1, 7]"
# "n, target-n**2: [1, 8]"
# "n, target-n**2: [0, 9]"
# "n, target-n**2: [-1, 8]"
# "n, target-n**2: [3, 9]"
# "backtrack? 2"
# "backtrack? 1"
# "n, target-n**2: [0, 13]"
# "n, target-n**2: [-1, 12]"
# "n, target-n**2: [1, 13]"
# "n, target-n**2: [0, 14]"
# "n, target-n**2: [-1, 13]"
# "n, target-n**2: [2, 14]"
# "backtrack? 1"
# "n, target-n**2: [0, 17]"
# "n, target-n**2: [-1, 16]"
# "n, target-n**2: [1, 17]"
# "n, target-n**2: [0, 18]"
# "n, target-n**2: [-1, 17]"
# "n, target-n**2: [9, 18]"
# "backtrack? 8" <--------------- Trying from 9 again
# "n, target-n**2: [7, -14]"
# "n, target-n**2: [6, -1]"
# "backtrack? 5" <--------------- Working
# "n, target-n**2: [4, -6]"
# "backtrack? 3"
# "n, target-n**2: [2, -3]"
# Currently inside 2nd return because target == 0, n > 0
# "n, target-n**2: [1, 0]" <--------- target == 0, return [] (not nil)
# Currently adding 1 to []
# "n, target-n**2: [3, 1]"
# Currently adding 3 to [1]
# "n, target-n**2: [5, 10]"
# Currently adding 5 to [1, 3]
# "n, target-n**2: [8, 35]"
# Currently adding 8 to [1, 3, 5]
# "n, target-n**2: [49, 99]"
# Currently adding 49 to [1, 3, 5, 8]
# final [1, 3, 5, 8, 49]

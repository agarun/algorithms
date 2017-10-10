# Say you have an array for which the ith element
# is the price of a given stock on day i.
#
# If you were only permitted to complete at most one
# transaction (ie, buy one and sell one share of the stock),
# design an algorithm to find the maximum profit.
#
# Example 1:
# Input: [7, 1, 5, 3, 6, 4]
# Output: 5
#
# max. difference = 6-1 = 5
# (not 7-1 = 6, as selling price needs to be larger than buying price)
#
# Example 2:
# Input: [7, 6, 4, 3, 1]
# Output: 0
#
# In this case, no transaction is done, i.e. max profit = 0.

# in [7, 1, 5, 3, 6, 4]
# the best profit is buying at min 1 and selling at next max 6
# importantly min is before the next max

# 4
def max_profit(prices)
  max_profit = 0
  min_cost = prices.first

  prices[1..-1].each do |price|
    min_cost = price if price < min_cost # min of price and cost
    max_profit = price - min_cost if price - min_cost > max_profit
  end

  max_profit
end

p max_profit([7, 1, 5, 3, 6, 4]) # => 5

# 3: Kadane's Algorithm
# See Leetcode 53: The Maximum Subarray Problem as well
# def max_subarray(A):
#     max_ending_here = max_so_far = A[0]
#     for x in A[1:]:
#         max_ending_here = max(x, max_ending_here + x)
#         max_so_far = max(max_so_far, max_ending_here)
#     return max_so_far
# if the array is [a, b, c, d] and our differences are [0, f, g, h]
# where `f = b - a`, `g = c - b`, `h = d - c`
# assuming `d - b` is the desired solution
# note `d - b` is also equal to `g + h` which is `-b +c-c + d`
# so it is the 'maximum subarray solution' `g + h` that we actually want
def max_profit(prices)
  max_ending_here = 0
  max_so_far = 0

  (1...prices.size).each do |idx|
    max_ending_here += prices[idx] - prices[idx - 1] # differences (see above)
    max_ending_here = [0, max_ending_here].max # To 0 if negative
    max_so_far = [max_so_far, max_ending_here].max
  end

  max_so_far
end

p max_profit([7, 1, 5, 3, 6, 4]) # => 5

# 2
# profit = revenue - cost
# maximize revenue, minimize cost
# O(n) time complexity, O(1) space
def max_profit(prices)
  min_cost = Float::INFINITY
  max_profit = 0

  prices.each do |price|
    if price < min_cost
      min_cost = price
    elsif price - min_cost > max_profit
      max_profit = price - min_cost
    end
  end

  max_profit
end

p max_profit([7, 1, 5, 3, 6, 4]) # => 5

# 1
# O(n)
# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  profit = 0
  stack = [] # holds our purchases

  prices.each do |price|
    if stack.empty?
      stack << price
      next
    elsif price - stack.last > profit # higher profit
      profit = price - stack.last
    elsif price < stack.last # lower buying price
      stack.pop
      stack << price
    end
  end

  profit
end

p max_profit([7, 1, 5, 3, 6, 4]) # => 5

# Say you have an array for which the ith element
# is the price of a given stock on day i.
#
# Design an algorithm to find the maximum profit.
# You may complete as many transactions as you like (
# ie, buy one and sell one share of the stock multiple times).
# However, you may not engage in multiple transactions at the
# same time (ie, you must sell the stock before you buy again).

# O(n) time
# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  (1...prices.size).reduce(0) do |profit, i|
    prices[i] - prices[i - 1] > 0 ? profit + prices[i] - prices[i - 1] : profit
  end
end

p max_profit([7, 1, 5, 3, 6, 4])

# there's an alternative solution in the leetcode published solution page
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/solution/
# total profit is sum of peak-valleys
# consider an index, increment till you find a valley, repeat to find a peak
# then add `peak - valley` to max_profit
# the outer loop will consider the index again to find the next pair of
# a peak & a valley if it can, and note the index will already be adjusted
# to the peak position

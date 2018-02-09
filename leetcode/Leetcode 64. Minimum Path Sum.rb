# Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right which minimizes the sum of all numbers along its path.
#
# Note: You can only move either down or right at any point in time.
#
# Example 1:
# [[1,3,1],
#  [1,5,1],
#  [4,2,1]]
# Given the above grid map, return 7. Because the path 1→3→1→1→1 minimizes the sum.

# @param {Integer[][]} grid
# @return {Integer}
def min_path_sum(grid)
  sums = min_path_sum_helper(grid)
  sums.last.last
end

# dp bottom-up
def min_path_sum_helper(grid)
  rows = grid.size
  cols = grid.first.size
  sums = Array.new(rows) { Array.new(cols) { 0 } }

  sums[0][0] = grid[0][0]

  # fill the costs for moving thru first row (right)
  # & moving thru col (down)
  (1...rows).each do |i|
    sums[i][0] = sums[i - 1][0] + grid[i][0]
  end

  (1...cols).each do |j|
    sums[0][j] = sums[0][j - 1] + grid[0][j]
  end

  # now when filling costs we can pick the min
  # between the value from either direction
  (1...rows).each do |i|
    (1...cols).each do |j|
      min_dir = [sums[i][j - 1], sums[i - 1][j]].min
      sums[i][j] = min_dir + grid[i][j]
    end
  end

  sums
end

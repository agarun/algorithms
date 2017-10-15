# Given an array S of n integers, are there elements a, b, c, and d in S
# such that a + b + c + d = target? Find all unique quadruplets in the array
# which gives the sum of target.
#
# Note: The solution set must not contain duplicate quadruplets.
#
# For example, given array S = [1, 0, -1, 0, -2, 2], and target = 0.
#
# A solution set is:
# [
#   [-1,  0, 0, 1],
#   [-2, -1, 1, 2],
#   [-2,  0, 0, 2]
# ]

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[][]}
def four_sum(nums, target)
  return [] if nums.size < 4

  nums.sort!

  quads = []

  (0...nums.size).each do |i|
    # avoid duplicates due to equal adjacent nums (i must not be 0 due to `i - 1`)
    next if nums[i - 1] == nums[i] && i > 0

    target_3sum = target - nums[i] # reduce to 3sum

    (i + 1...nums.size).each do |j|
      # avoid duplicates due to equal adjacent nums for the 2nd number
      # note we must start at `j > i + 1`
      next if nums[j - 1] == nums[j] && j > i + 1

      target_2sum = target_3sum - nums[j] # reduce to 2sum

      low = j + 1
      high = nums.size - 1

      while low < high
        sum = nums[low] + nums[high]

        if sum == target_2sum
          quad = [nums[i], nums[j], nums[low], nums[high]]
          quads << quad

          # avoid duplicates by moving pointer away from them
          # note we will move low & high at the end of this body regardless,
          # but we want to move it away from the dupe with these lines if
          # there is indeed a duplicate number (to prevent getting same quad)
          low += 1 while low < high && nums[low] == nums[low + 1]
          high -= 1 while low < high && nums[high - 1] == nums[high]

          low += 1
          high -= 1
        elsif sum > target_2sum
          # we want to look at lower values to get closer to the target, thus:
          high -= 1
        else # when sum < target_2sum, we want to look at higher values
          low += 1
        end
      end
    end
  end

  quads
end

# alternative solution would have the same nested structure but keep a hash
# keys are complements (target - (nums[i] + nums[j]))
# and we can store the other 2 numbers that build the target in the value,
# when they form the target, we can push it to a result array.
# unfortunately we'd still have to O(n log n) sort in this case

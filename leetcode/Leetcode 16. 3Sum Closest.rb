# Given an array S of n integers, find three integers in S such that
# the sum is closest to a given number, target. Return the sum of the
# three integers.
# You may assume that each input would have exactly one solution.
#
# For example, given array S = {-1 2 1 -4}, and target = 1.
#
# The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).

# O(n^2)
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def three_sum_closest(nums, target)
  nums.sort!

  distance = Float::INFINITY
  closest_sum = nil

  nums[0...-1].each_with_index do |num, idx|
    low = idx + 1
    high = nums.size - 1

    while low < high
      sum = nums[idx] + nums[low] + nums[high]

      if sum == target
        return sum
      elsif sum > target
        high -= 1
      else
        low += 1
      end

      if (target - sum).abs < distance
        closest_sum = sum
        distance = (target - sum).abs
      end
    end
  end

  closest_sum
end

# without declaring `distance` explicitly, but same concept:
def three_sum_closest(nums, target)
  nums.sort!  # O(n log n)

  # we want to minimize the distance: (target - sum).absolute value
  # for each num at `i`, theres `j` and `k` indices where the distance/diff is minimized

  closest_sum = Float::INFINITY

  (0..nums.size - 2).each do |i|
    j = i + 1
    k = nums.size - 1

    while j < k
      sum = nums[i] + nums[j] + nums[k]

      # if the distance from targ to current sum is smaller than dist to closest_sum
      if (target - sum).abs < (target - closest_sum).abs
        closest_sum = sum
        return sum if sum == target # i.e. is the distance 0
      end

      if sum > target
        k -= 1 # high
      else
        j += 1 # low
      end
    end
  end

  closest_sum
end

# brute force is O(n^3)

# Given an array of integers, return indices of the
# two numbers such that they add up to a specific target.
#
# You may assume that each input would have exactly one solution,
# and you may not use the same element twice.
#
# Example:
# Given nums = [2, 7, 11, 15], target = 9,
#
# Because nums[0] + nums[1] = 2 + 7 = 9,
# return [0, 1].

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  complements = {}

  nums.each_with_index do |num, idx|
    if complements[target - num]
      return [idx, complements[target - num]]
    else
      complements[num] = idx
    end
  end
end

def two_sum(nums, target)
  (0...nums.size).each do |i|
    (i + 1...nums.size).each do |j|
      return [i, j] if nums[i] + nums[j] == target
    end
  end
end

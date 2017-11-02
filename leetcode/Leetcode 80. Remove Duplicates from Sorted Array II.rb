# Follow up for "Remove Duplicates" #26.
# What if duplicates are allowed at most twice?
#
# For example,
# Given sorted array nums = [1,1,1,2,2,3],
#
# Your function should return length = 5, with the first
# five elements of nums being 1, 1, 2, 2 and 3.
# It doesn't matter what you leave beyond the new length.

# O(n)
# @param {Integer[]} nums
# @return {Integer}
def remove_duplicates(nums, max_repeat = 2)
  repeats = 0 # keeps track of how many repeats there are
  count = 0 # pointer, only moves when the value occurrence doesnt exceed max_repeat
  i = 1 # iterate through the `nums` array

  while i < nums.size
    if nums[i - 1] != nums[i]
      # if adjacent values are unique declare 1 repeat (at this current pos)
      # increment `count` (to indicate unique) & give it unique value (for comparison)
      repeats = 1
      nums[count] = nums[i - 1]
      count += 1
    else
      # if adjacent values are identical, there is a repeat!
      repeats += 1

      # only iterate `count` if doesn't exceed `max_repeat`
      if repeats <= max_repeat
        nums[count] = nums[i]
        count += 1
      end
    end

    i += 1
  end

  count
end

p remove_duplicates([1, 1, 1, 2, 2, 3]) # => 5

# @param {Integer[]} nums
# @return {Integer}
def remove_duplicates(nums)
  count_idx = 0

  nums.each_index do |num_idx|
    if count_idx < 2 || nums[num_idx] > nums[count_idx - 2]
      nums[count_idx] = nums[num_idx] # change for comparison
      count_idx += 1 # increment to denote a 'non-duplicate'
    end
  end

  count_idx
end

p remove_duplicates([1, 1, 1, 2, 2, 3]) # => 5

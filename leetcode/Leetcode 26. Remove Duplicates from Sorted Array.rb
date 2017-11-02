# Given a sorted array, remove the duplicates
# in place such that each element appear only once
# and return the new length.
#
# Do not allocate extra space for another array,
# you must do this in place with constant memory.
#
# For example,
# Given input array nums = [1,1,2],
#
# Your function should return length = 2,
# with the first two elements of nums being 1 and 2 respectively.
# It doesn't matter what you leave beyond the new length.

# O(n) time complexity
def remove_duplicates(nums)
  return if nums.empty?

  # `i` is a counter that increments when elements are unique
  # `j` is the index in the array, it can start at 1 since i is first compared at 0
  i = 0
  j = 1

  while j < nums.size
    if nums[i] != nums[j]
      i += 1

      # i should point to the most recent unique for the next comparison
      # therefore `i + 1` (note `i` increments just before) should have `j`'s current value
      nums[i] = nums[j]
    end

    j += 1
  end

  # add 1 to include the last value checked, which will never be compared as `i`
  i + 1
end

p remove_duplicates([1, 1, 2]) # => 2

# equivalent
def remove_duplicates(nums)
  return if nums.empty?

  count = 0

  (1...nums.size).each do |index|
    next if nums[count] == nums[index]

    count += 1
    nums[count] = nums[index]
  end

  count + 1
end

p remove_duplicates([1, 1, 2]) # => 2

# to actually remove duplicate elements, adjust the first implementation
# to build a new array of uniques, or alternatively:
def remove_duplicates(nums)
  i = 0
  j = 1

  while j < nums.size
    if nums[i] == nums[j]
      # found a repeat -> cut away the duplicate + reset the search
      nums = j == nums.size - 1 ? nums[0..i] : nums[j..-1]
      i = 0
      j = 1
    else
      i += 1
      j += 1
    end
  end

  nums.size
end

p remove_duplicates([1, 1, 2]) # => 2

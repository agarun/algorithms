# Given an array of integers that is already sorted in ascending order,
# find two numbers such that they add up to a specific target number.
#
# The function twoSum should return indices of the two numbers
# such that they add up to the target, where index1 must be less than index2.
#
# ---> Please note that your returned answers (both index1 and index2) are not zero-based. <---
#
# You may assume that each input would have exactly one solution
# and you may not use the same element twice.
#
# Input: numbers={2, 7, 11, 15}, target=9
# Output: index1=1, index2=2

# @param {Integer[]} numbers
# @param {Integer} target
# @return {Integer[]}
def two_sum(numbers, target)
  complements = {}

  numbers.each_with_index do |num, idx|
    if complements[target - num]
      return [complements[target - num], idx + 1]
    else
      complements[num] = idx + 1
    end
  end
end

# pointers
# e.g. we have some array [2, 7, 11, 15], target 18
# two pointers for start & end
# first compare 2 + 15
# if that sum is 18, return, otherwise,
# since this array is _SORTED_, we can simply move the pointer based on
# whether the sum is greater than or less than the target
# e.g. if our sum > target, we want to move `high` down 1
# else if our sum < target, we want to move `low` up 1
def two_sum(numbers, target)
  low = 0
  high = numbers.size - 1

  until low == high
    sum = numbers[low] + numbers[high]
    case sum <=> target
    when 0
      return [low + 1, high + 1] # NOT zero-indexed!
    when 1 # sum > target
      high -= 1
    when -1 # sum < target
      low += 1
    end
  end
end

# Binary Search: worst case O(nlogn)
# recall there is a guaranteed solution in our test cases
def two_sum(numbers, target)
  numbers.each_with_index do |num, idx|
    # why `idx + 1`? because we don't want to include the number in our search
    # so if we start at idx 0, we want to search from 1..end for the complement
    # also, so we don't re-search smaller numbers, since this array is sorted.
    low = idx + 1
    high = numbers.size - 1
    search = target - num

    while low <= high
      mid = (low + high) / 2

      if numbers[mid] == search
        return [idx + 1, mid + 1] # NOT zero-indexed!
      elsif numbers[mid] > search
        # note we ignore including `mid` on next search for both `high` and `low`
        # and our first condition already takes care of `mid`
        high = mid - 1
      else
        low = mid + 1
      end
    end
  end
end

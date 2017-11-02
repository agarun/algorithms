# Suppose an array sorted in ascending order is
# rotated at some pivot unknown to you beforehand.
#
# (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
#
# Write a function to determine if a given target is in the array.
#
# The array may contain duplicates.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Boolean}
def search(nums, target)
  low = 0
  high = nums.size - 1

  while low <= high
    mid = (low + high) / 2

    if nums[mid] == target
      return true
    elsif nums[mid] > nums[low]
      if nums[low] <= target && nums[mid] > target
        high = mid - 1
      else
        low = mid + 1
      end
    elsif nums[mid] < nums[low]
      if nums[mid] < target && nums[high] >= target
        low = mid + 1
      else
        high = mid - 1
      end
    elsif nums[low] == nums[mid]
      low += 1
    end
  end

  false
end

p search([4, 5, 6, 7, 0, 1, 2], 5) # => true
p search([1, 3, 5], 1) # => true

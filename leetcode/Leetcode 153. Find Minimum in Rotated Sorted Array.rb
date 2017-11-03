# Suppose an array sorted in ascending order is rotated
# at some pivot unknown to you beforehand.
#
# (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
#
# Find the minimum element.
#
# You may assume no duplicate exists in the array.

# e.g. [4, 5, 6, 7, 0, 1, 2].

# if the first element is less than the last element, it's sorted (first case)
# (first element < last element only true for sorted)

# if the first element is greater than the last element it's rotated (second case)
# => which side is the minimum on?
# => take the mid
#   => if the first element <= mid el (== last < mid), the left side has sequentially bigger nums,
#   => thus the right side has the min in the smaller nums (take the right side)
#   => if the first element > mid, the sequentially bigger nums end somewhere before
#   => the mid, thus the min must be part of the nums before the mid (take the left side)

# O(log n)
# @param {Integer[]} nums
# @return {Integer}
def find_min(nums)
  low = 0
  high = nums.size - 1

  # if some value A < some value B, we want to move away from B
  until low == high
    if nums[low] < nums[high]
      # array *must* be sorted
      return nums[low]
    else
      mid = (low + high) / 2

      # why `<=`? consider nums = [2, 1], where low and mid are *both* at value `2`
      if nums[low] <= nums[mid] # or equivalently `if nums[mid] > nums[high]` b/c of first `if`
        low = mid + 1
      else
        high = mid
      end
    end
  end

  nums[low]
end

p find_min([4, 5, 6, 7, 0, 1, 2]) # => 0

# O(log n)
# @param {Integer[]} nums
# @return {Integer}
def find_min(nums)
  low = 0
  high = nums.size - 1

  until low == high
    mid = (low + high) / 2

    # mid el > high el *always* true when the right side has the min
    if nums[mid] > nums[high]
      low = mid + 1
    else
      high = mid
    end
  end

  nums[low]
end

p find_min([4, 5, 6, 7, 0, 1, 2]) # => 0

# O(n)
# @param {Integer[]} nums
# @return {Integer}
def find_min(nums)
  low = 0
  high = nums.size - 1

  # if some value A < some value B, we want to move away from B
  until low == high
    if nums[low] < nums[high]
      high -= 1
    else
      low += 1
    end
  end

  nums[low]
end

p find_min([4, 5, 6, 7, 0, 1, 2]) # => 0

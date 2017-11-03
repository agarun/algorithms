# Find the contiguous subarray within an array (containing at least one number)
# which has the largest product.
#
# For example, given the array [2, 3, -2, 4],
# the contiguous subarray [2, 3] has the largest product = 6.

# O(n)
# similar to Kadane's (maximum subarray at each index, dump if < 0)
# @param {Integer[]} nums
# @return {Integer}
def max_product(nums)
  # global max
  product = nums.first

  # local min and max up to current index
  # min is necessary in case a value is negative
  max_here = nums.first
  min_here = nums.first

  nums[1..-1].each do |num|
    # if `num` is negative, reverse the order of checking max & min
    max_here, min_here = min_here, max_here if num < 0

    # calculate the max and min product up to this index
    # the first candidate `num` resets the contiguous subarray in case *it* is the max/min
    # the second candidate `num * [min|max]_here` considers elongating the contiguous subarray
    max_here = [num, num * max_here].max
    min_here = [num, num * min_here].min

    # can still consider `max_here` if a value is negative due to the swap
    product = [product, max_here].max
  end

  product
end

p max_product([2, 3, -2, 4]) # => 6

# @param {Integer[]} nums
# @return {Integer}
def max_product(nums)
  product = nums.first
  max_here = nums.first
  min_here = nums.first

  nums[1..-1].each do |num|
    max_temp = max_here
    max_here = [num, num * max_temp, num * min_here].max
    min_here = [num, num * max_temp, num * min_here].min

    product = [product, max_here].max
  end

  product
end

p max_product([2, 3, -2, 4]) # => 6

# brute force

# @param {Integer[]} nums
# @return {Integer}
def max_product(nums)
  products = {}
  max_product = -Float::INFINITY

  (0...nums.size).each do |i|
    (i...nums.size).each do |j|
      subarray = nums[i..j]
      products[subarray] = subarray.reduce(:*) if !products[subarray]
      max_product = products[subarray] if max_product < products[subarray]
    end
  end

  max_product
end

p max_product([2, 3, -2, 4]) # => 6

# @param {Integer[]} nums
# @return {Integer}
def max_product(nums)
  # make all the permutations -> go through each one -> set the subarray if it's a max product
  max_product = -Float::INFINITY
  max_product_subarray = []

  (0...nums.size).each do |i|
    (i...nums.size).each do |j|
      subarray = nums[i..j]
      current_product = subarray.reduce(:*)

      if max_product < current_product
        max_product = current_product
        max_product_subarray = subarray
      end
    end
  end

  max_product_subarray
end

p max_product([2, 3, -2, 4]) # => [2, 3]

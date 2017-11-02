# Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array),
# some elements appear twice and others appear once.
#
# Find all the elements that appear twice in this array.
#
# Could you do it without extra space and in O(n) runtime?

# since an element's value <= the size of the array, use the value as an index
# to mark whether a particular number has been traversed prior by making it negative
# if traversal reaches a negative value, it must be a dupe
# note: consider the range.. an element a[i] could be equal to the size of the array
# ..this requires checking the index `num.abs - 1`
# @param {Integer[]} nums
# @return {Integer[]}
def find_duplicates(nums)
  dupes = []

  nums.each do |num|
    if nums[num.abs - 1] > 0
      nums[num.abs - 1] *= -1
    else
      dupes << num.abs
    end
  end

  dupes
end

p find_duplicates([4, 3, 2, 7, 8, 2, 3, 1]) # => [2, 3]

# Brute Force
# @param {Integer[]} nums
# @return {Integer[]}
def find_duplicates(nums)
  num_counts = nums.reduce(Hash.new(0)) { |count, n| count[n] += 1; count }
  num_counts.select { |n, count| count == 2 }.keys
end

p find_duplicates([4, 3, 2, 7, 8, 2, 3, 1]) # => [2, 3]

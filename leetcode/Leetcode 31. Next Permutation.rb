# Implement next permutation, which rearranges numbers
# into the lexicographically next greater permutation of numbers.
#
# If such arrangement is not possible, it must rearrange
# it as the lowest possible order (ie, sorted in ascending order).
#
# The replacement must be in-place, do not allocate extra memory.
#
# Here are some examples.
# Inputs are in the left-hand column
# and its corresponding outputs are in the right-hand column.
# 1,2,3 → 1,3,2
# 3,2,1 → 1,2,3
# 1,1,5 → 1,5,1

# Lexographical order

# e.g. 1, 2, 3 -> 1 < 2 < 3

# we observe that with [3, 2, 1] "no arrangement is possible"
# so it must rearrange to the "lowest possible order"
# which could be accomplished by a REVERSE step

# our goal is to find where it's appropriate to REVERSE
# we've seen that for an array in descending order, we'd REVERSE the entire array
# if instead, we find an element that is smaller than the next element,
# we can't reverse the entire array, so this could be a marker

# i.e.:
# say we look at the entire array from the back
# if we find that every element is greater than the last (moving right to left now instead)
# then we expect to reverse the entire array. however,
# if instead we find some element nums[i], and nums[i - 1] has a smaller value
# then we should reverse something only between nums[i - 1] and the end of the array!
# before reversing, we should find the number closest to AND greater than nums[i]
# and swap the two, so that when we reverse, we get the next lexicographically
# greater sequence. if we don't do this swap step, we might skip some sequences.

# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def next_permutation(nums)
  i = nums.size - 1

  # if we find an element that's not increasing from the back..
  # i ends as the last position of an increasing sequence from the back
  ## e.g. in [1, 5, 8, 3, 4, 2, 1, 1] `i` ends as index 4 here
  # i - 1: the position of the 'smaller' element. in e.g.^ `i - 1` is pos 3
  while i > 0 && nums[i - 1] >= nums[i]
    i -= 1
  end

  if i > 0 # i.e. if it's not a solely descending array
    j = nums.size - 1

    # keep decrementing `j` until the value at j is as close to the value
    # at `i - 1` (the 'small' element) as possible
    while j > 0 && nums[j] <= nums[i - 1]
      j -= 1
    end

    # swap between `i - 1` (the 'small' el) and `j`, the closest value
    nums[i - 1], nums[j] = nums[j], nums[i - 1]
  end

  # reverse everything from the last greater element to the end
  nums[i..-1] = nums[i..-1].reverse
  nums
end

p next_permutation([1, 2, 3]) # => 1, 3, 2
p next_permutation([3, 2, 1]) # => 1, 2, 3
p next_permutation([1, 1, 5]) # => 1, 5, 1
p next_permutation([1, 5, 8, 3, 4, 2, 1, 1]) # => [1, 5, 8, 4, 1, 1, 2, 3]

# also:
# from wikipedia https://en.wikipedia.org/wiki/Permutation
# same concept
# Find the largest index `k` such that `a[k] < a[k + 1]`.
## If no such index exists, the permutation is the last permutation
# Find the largest index `l` greater than `k` such that `a[k] < a[l]`
# Swap the value of `a[k]` with that of `a[l]`.
# Reverse the sequence from `a[k + 1]` up to and
# including the final element `a[n]`.
# -- see the example --
# https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order

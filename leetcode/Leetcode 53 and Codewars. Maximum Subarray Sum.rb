# The maximum sum subarray problem consists in finding the maximum sum
# of a contiguous subsequence in an array or list of integers:
#
# maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
# -- should be 6: [4, -1, 2, 1]
# Empty list is considered to have zero greatest sum. Note that
# the empty list or array is also a valid sublist/subarray.

# Kadane's algorithm
# "this algorithm can be viewed as simple/trivial example of dynamic programming"
# in Dynamic programming same subproblem will not be solved multiple times
# but the prior result will be used to optimise the solution
# O(n)

# def max_subarray(A):
#     max_ending_here = max_so_far = A[0]
#     for x in A[1:]:   # <----- note it's from 1 to end, not from 0, bc we initialized the vars as A[0]
#         max_ending_here = max(x, max_ending_here + x)
#         max_so_far = max(max_so_far, max_ending_here)
#     return max_so_far
def max_subarray_sum(array)
  sum = 0
  sum_to_here = 0

  array.each do |num|
    # if num is a max, we reset the sequence. otherwise, it keeps growing!
    # the max is either the current element or the current element COMBINED with the rest of em!
    sum_to_here = [num, sum_to_here + num].max # local maxim
    # the sum will only update if the growing sequence is a new max.
    sum = [sum, sum_to_here].max
  end

  sum # the last sequential sum is the greatest contiguous sum!
end

p max_subarray_sum([-2, 1, -3, 4, -1, 2, 1, -5, 4]) # => 6

# if the list is made up of only positive numbers add all of them up
# if the list is made up of only negative numbers return 0
def max_subarray_sum(array)
  max_sum = 0
  max_sum_until_current = 0

  array.each do |num|
    max_sum_until_current += num # build sum of contiguous sequence

    if max_sum_until_current < 0
      max_sum_until_current = 0 # reset contiguous sequence, dump previous
    elsif max_sum_until_current > max_sum
      max_sum = max_sum_until_current
    end
  end

  max_sum # the last sequential sum. 0 if all nums were negative
end

p max_subarray_sum([-2, 1, -3, 4, -1, 2, 1, -5, 4]) # => 6

# DIVIDE AND CONQUER ALGORITHM:
# 1 . Select the middle element in the array
#   . The max subarray either has this element, or it doesn't
# 2a. If the maximum subarray DOES NOT contain the middle element
#   . Then recurse with the left & the right
# 2b. If the maximum subarray DOES contain the middle element
#   . the result will be simply the maximum suffix subarray of the
#   . left subarray plus the maximum prefix subarray of the right subarray
# 3 . Take the maximum of the 3 cases above.
# O ( n log n)

def max_sub_array(nums)
  sub_array(nums, 0, nums.size - 1)
end

def sub_array(nums, left, right)
  return nums[left] if left == right

  mid = (left + right) / 2 # 1.

  left_ans = sub_array(nums, left, mid) # 2a.
  right_ans = sub_array(nums, mid + 1, right) # 2a.

  left_max = nums[mid] # 2b. & below to add suffixes
  right_max = nums[mid + 1] # 2b. & below to add suffixes

  temp = 0

  mid.downto(left) do |i|
    temp += nums[i]
    left_max = temp if left_max < temp
  end

  temp = 0

  (mid + 1).upto(right) do |j|
    temp += nums[j]
    right_max = temp if right_max < temp
  end

  two_a = [left_ans, right_ans].max
  two_b = left_max + right_max
  [two_a, two_b].max
end

p max_sub_array([-2, 1, -3, 4, -1, 2, 1, -5, 4]) # => 6

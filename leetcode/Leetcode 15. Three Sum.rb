# Given an array S of n integers, are there elements a, b, c in S
# such that a + b + c = 0? Find all unique triplets in the array
# which gives the sum of zero.
#
# Note: The solution set must not contain duplicate triplets.
#
# For example, given array S = [-1, 0, 1, 2, -1, -4],
#
# A solution set is:
# [
#   [-1, 0, 1],
#   [-1, -1, 2]
# ]

# sorting array first (passes time limit)
# O(n^2) time complexity (worst case)
# The two_sum with sorted array problem involves 2 pointers, moving each one
# depending on the difference between sum of the vals at pointers & the target val
# We can apply this here by first sorting our input array. then iterate through
# `nums`, at each `num`, we need to find the pair that sums to `0 - num` (-num)
# note that a duplicate may occur if we process any equivalent adjacent values
# so we have to ensure that we don't choose duplicate triplets
def three_sum(nums)
  triplets = []

  nums.sort!

  # [0...-1] because we don't need to check the last idx since `low` is i + 1
  nums[0...-1].each_with_index do |num, i|
    # the array is sorted, can't reach 0 if num > 0 -> exit
    break if num > 0

    # __duplicates of 'first' number__
    next if nums[i] == nums[i - 1] && i != 0 # don't compare 0 and -1

    target = -num
    low = i + 1
    high = nums.size - 1

    while low < high
      sum = nums[low] + nums[high]

      if sum == target
        triplets.push([nums[i], nums[low], nums[high]])

        # __duplicates of 'start' number__
        # if the sum is equal to the target, we need to take care of duplicates.
        # if the num after nums[low] is a dupe of nums[low], we'll get the same answer
        # so move it until it's not the same.
        # note that there might be MULTIPLE duplicates, so we have to wrap it in a
        # `while` loop, and we have to ensure low < high, because moving either pointer
        # might make them equal one another (once that's the case, the outer `while` ends)
        low += 1 while low < high && nums[low] == nums[low + 1]

        # __duplicates of 'end' number__
        # if the num before nums[high] is a dupe of nums[high], we'll get the same answer
        # similarly, move it until this isn't the case, ensuring low < high all the while
        high -= 1 while low < high && nums[high] == nums[high - 1]

        # if it's not the case that either have adjacent dupes, we can iterate both
        low += 1
        high -= 1
      elsif sum > target
        # in a sorted array, if our sum > target, lower the high pointer
        high -= 1
      else # sum < target, i.e. raise the low pointer
        low += 1
      end
    end
  end

  triplets
end

def three_sum(nums)
  triplets = []

  nums.sort!

  nums.each_with_index do |num, i|
    break if num > 0 || i > nums.size - 2

    # avoid duplicates
    next if nums[i] == nums[i - 1] && i > 0

    low = i + 1
    high = nums.size - 1
    target = -num # add -num to num to equal 0

    while low < high
      sum = nums[low] + nums[high]

      if sum == target
        triplets << [nums[i], nums[low], nums[high]]

        # avoid duplicates
        low += 1 while low < high && nums[low] == nums[low + 1]
        high -= 1 while low < high && nums[high - 1] == nums[high]

        low += 1
        high -= 1
      elsif sum > target
        high -= 1
      else # sum < target
        low += 1
      end
    end
  end

  triplets
end

# => if the question was simply to return whether a 3sum exists, we could
# do this very simply:
# a + b + c = 0 ~> a + b = -c ~> c = -(a + b)
# inserting each number in nums into a hash table (say it's our `c`)
# does hash have element -(a + b)? note `c` CAN'T be either a or b.

# two_sum use (time limit exceeded)
# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum(nums)
  uniques = []

  nums.each_with_index do |num, idx|
    uniques = two_sum(nums[idx + 1...nums.length], 0 - num, uniques)
  end

  uniques
end

def two_sum(nums, target, uniques)
  comps = {}

  nums.each do |num|
    if comps[target - num]
      triple = [0 - target, target - num, num].sort
      uniques << triple unless uniques.include?(triple)
    else
      comps[num] = true
    end
  end

  uniques
end

# brute force (time limit exceeded)
# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum(nums)
  uniques = []

  (0...nums.size).each do |i|
    (i + 1...nums.size).each do |j|
      (j + 1...nums.size).each do |k|
        triple = [nums[i], nums[j], nums[k]].sort
        valid = nums[i] + nums[j] + nums[k] == 0
        uniques << triple if valid && !uniques.include?(triple)
      end
    end
  end

  uniques
end

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

def remove_duplicates(nums)
  return if nums.empty?

  i = 0
  j = 1

  while j < nums.size
    if nums[i] != nums[j]
      # if these els aren't equal, they are uniques!
      i += 1

      # set i to point to the new unique & discard the repeat
      nums[i] = nums[j]
    end

    j += 1
  end

  i + 1 # + 1 to account for the j
end

p remove_duplicates([1, 1, 2])

def remove_duplicates(nums)
  return if nums.empty?

  catchup = 0

  (1...nums.size).each do |index|
    next if nums[catchup] == nums[index]

    catchup += 1
    nums[catchup] = nums[index]
  end

  catchup + 1
end

p remove_duplicates([1, 1, 2])

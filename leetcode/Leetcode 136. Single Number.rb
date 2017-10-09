# Given an array of integers, every element appears twice except for one. Find that single one.
#
# Note:
# Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

# 1
# @param {Integer[]} nums
# @return {Integer}
def single_number(nums)
  result = {}

  nums.each do |n|
    result[n].nil? ? result[n] = n : result[n] = nil
  end

  result.values.compact.first
end

p single_number([17, 12, 5, -6, 12, 4, 17, -5, 2, -3, 2, 4, 5, 16, -3, -4, 15, 15, -4, -5, -6])

# Iterate through all elements in nums
# Try if hash_table has the key for pop
# If not, set up key/value pair
# In the end, there is only one element in hash_table, so use popitem to get it

# 2
def single_number(nums)
  result = {}

  nums.each do |n|
    # delete in ruby is slow... this one isn't as fast as mine
    result[n].nil? ? result[n] = n : result.delete(n)
  end

  result.shift.first
end

p single_number([17, 12, 5, -6, 12, 4, 17, -5, 2, -3, 2, 4, 5, 16, -3, -4, 15, 15, -4, -5, -6])

# Time complexity: O(n + 1? idk about .delete())
# Space: O(n)

# Math solution
# 2 * (A + B + C) - (A + A + B + B + C) = C

# 3
def single_number(nums)
  2 * nums.uniq.reduce(:+) - nums.reduce(:+)
end

p single_number([17, 12, 5, -6, 12, 4, 17, -5, 2, -3, 2, 4, 5, 16, -3, -4, 15, 15, -4, -5, -6])

# Time complexity: O(n + n) = O(n)

# Space complexity: O(n + n) = O(n). the set needs space for the elements in nums


# Ruby bitwise XOR
#
# If we take XOR of zero and some bit, it will return that bit
# a ^ 0 = a
# If we take XOR of two same bits, it will return 0
# a ^ a = 0
# a ^ b ^ a = (a ^ a) ^ b = 0 ^ b = b
# So we can XOR all bits together to find the unique number.

# For each bit in the binary representation of the operands, a bitwise XOR
# will get a 1 bit if one of the corresponding bits in the operands is 1,
# but not both, otherwise the XOR will get a 0 bit. Here's an example:

# 5 is 101, 6 is 110, 5 ^ 6 = 011 = 3
# 5 ^ 5 = 0
# 4

# The first element in the array is taken as the memo and the
# second element is taken as the num. memo takes the result of the comparison,
# compares to the 3rd element, and so on. the idea is that the pairs of integers
# will cancel out with XOR, leaving only the number of interest

# e.g. 5 ^ 5 ^ 6 ^ 7 ^ 7 => 6
def single_number(nums)
  nums.reduce(:^) # { |memo, num| memo ^ num }
end

p single_number([17, 12, 5, -6, 12, 4, 17, -5, 2, -3, 2, 4, 5, 16, -3, -4, 15, 15, -4, -5, -6])

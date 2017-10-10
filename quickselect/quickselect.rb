# Selection algorithm
# An algorithm for finding the kth smallest number in a list or array
# where such a number is the 'kth order statistic'

# Hoare's Quickselect
# In-place algorithm

# Choose a pivot element at random
# Partition the array as in quicksort
# Instead of recursing into both sides, we will just choose ONE side

def partition(array, low, high)
  random_index = rand(low..high)
  pivot = array[random_index]

  # swap pivot to the end
  array[random_index], array[high] = array[high], array[random_index]

  # set up the partition_index
  partition_index = low

  (low...high).each do |current_index|
    if array[current_index] < pivot
      array[current_index], array[partition_index] = array[partition_index], array[current_index]
      partition_index += 1
    end
  end

  # swap pivot to partition_index
  array[high], array[partition_index] = array[partition_index], array[high]

  # now the index of the pivot
  partition_index
end

# why is quickselect faster?
# because in a quicksort, we must recursively sort both branches
# in a quickselect, since we are looking for a desired element, we can take
# advantage of the fact that everything to the left of the pivot is smaller,
# and vice versa for everything to the right, so can search just one side

# In this example, we will be searching `array` for the 'kth smallest element'
def quickselect(array, low, high, k)
  return array[low] if low == high

  partition_index = partition(array, low, high)

  # since the pivot is now in its final sorted position, we can
  # check where to look for our desired element
  case partition_index <=> k
  when 0
    # everything to the left of part_idx is smaller, to the right is greater
    return array[k]
  when 1 # >
    return quickselect(array, low, partition_index - 1, k)
  when -1 # <
    return quickselect(array, partition_index + 1, high, k)
  end
end

p quickselect([5, 9, 14, 3, 1, 6, 4, 7, 11], 0, 8, 0) # =>  1
p quickselect([5, 9, 14, 3, 1, 6, 4, 7, 11], 0, 8, 4) # =>  6
p quickselect([5, 9, 14, 3, 1, 6, 4, 7, 11], 0, 8, 8) # =>  14

# we can also replace the tail recursion of quickselect with a loop:

def quickselect(array, low, high, k)
  while true
    return array[low] if low == high
    partition_index = partition(array, low, high)

    if partition_index == k
      return array[k]
    elsif partition_index > k
      high = partition_index - 1
    else
      low = partition_index + 1
    end
  end
end

p quickselect([5, 9, 14, 3, 1, 6, 4, 7, 11], 0, 8, 0) # =>  1
p quickselect([5, 9, 14, 3, 1, 6, 4, 7, 11], 0, 8, 4) # =>  6
p quickselect([5, 9, 14, 3, 1, 6, 4, 7, 11], 0, 8, 8) # =>  14

#
# Time complexity:
# Worst-case: O(n^2)
# Best-case: O(n)
#
# Space complexity (first method): O(1) since it's in-place comparison.

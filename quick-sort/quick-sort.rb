#
# Lomuto partition schemes
#
# Divide:
#
# Step 1 - Choose the pivot element, an item `p`
# Step 2 - Partition operation
# elements with values less than `p` come before `p`
# elements w values greater than `p` come after
# -> Accomplish by dividing items of array into three parts
## array[i..m - 1], could be empty, contains items < `p`
## array[m], m is the correct position for pivot `p` in sorted array
## array[m + 1..j], could be empty, contains items >= `p`
# Step 3 - Recursively repeat the steps, then sort the parts

#
# Space complexity:

#
# Time complexity: O(1), in-place comparison sort

def quick_sort(array, low = 0, high = array.size - 1)
  if low < high
    partition_idx = partition(array, low, high)
    # passing refs -> array is mutated after calling partition
    quick_sort(array, low, partition_idx - 1)
    quick_sort(array, partition_idx + 1, high)
  end

  array
end

def partition(array, low, high)
  # arbitrarily choose pivot to be the first element (val at idx 0)
  pivot = array[low]

  # let partition_idx be at the first element after the pivot (unsorted arr)
  partition_idx = low + 1

  (low + 1..high).each do |current_idx|
    if array[current_idx] < pivot
      # swap with the element at the partition_idx in order to divide
      # vals < pivot from those >= pivot. at any stage, any elements to the left
      # of partition_idx are smaller than the element at partition_idx
      array[partition_idx], array[current_idx] = array[current_idx], array[partition_idx]
      partition_idx += 1
    end
  end

  # partition_idx - 1 is the last element that's smaller than the pivot
  # so we can swap the pivot (array[low]) and the smaller element to achieve
  # an array where everything to the left of pivot is smaller than pivot
  array[partition_idx - 1], array[low] = array[low], array[partition_idx - 1]

  # now the value at partition_idx - 1 is the pivot!
  partition_idx - 1
end

p quick_sort([27, 38, 12, 39, 27, 16])

# Visualgo.net example
# Partition Call #1
# -----------------
# [27, 38, 12, 39, 27, 16] has indices 0 to 5 inclusive
# pivot = 27 at idx 0
# partition idx = 1
# checking from pivot idx + 1 to end of array
# is 38 < 27? nope, pass
# is 12 < 27? yes
## swap 12 and 38
### 12 is the value at current_idx (2)
### 38 is the value at partition_idx (1)
## increment partition_idx (1+1)
# [27, 12, 38, 39, 27, 16]
# at this point, we see any value behind the partition_idx
# will be smaller than the value at the partition index
# after all the swaps are complete
# is 39 < 27? nope
# is 27 < 27? nope
# is 16 < 27? yes
## swap 16 and 38
### 16 is the value at current_idx (5)
### 38 is the value at partition_idx (2) after our first swap
## increment partition_idx (2+1)
# [27, 12, 16, 39, 27, 38]
# loop is complete
# now we have to move our pivot element in front of the elements
# to the left of the partition index
## the partition_idx finished at 3, where value is 39
## to the left we have: 27, 12, 16
## so we can swap 16 and 27
## i.e. we can swap position 0 (pivot idx) and pos 2 (partition_idx - 1)
# our final array for this partitioning:
# [16, 12, 27, 39, 27, 38]
# our pivot was 27. everything to the left < 27, to the right >= 27
# i.e. pivot is now at its sorted position
#
# Partition Call #2
# -----------------
# we called quick_sort on the array [16, 12]
# 16 is taken as the pivot at idx 0
# partition_idx is 1
# is 12 < 16? yes
## swap indices 1 and 1...
## increment partition_idx (1+1)
## swap idxs 0 and 2-1
# [12, 16, 27, 39, 27, 38]
#
# Partition Call #"3" <- Doesn't make it because `if low < high` fails
# -----------------
# would be called with [12]
# since partition size is 1, the element inside the partition
# is already at its sorted position
# quick_sort returns nothing + resumes other recursions
#
# Partition Call #4
# -----------------
# [12, 16, 27, 39, 27, 38]
# 39 is taken as the pivot at idx 3
# partition_idx is 4
# is 27 < 39? yes
## swap idx 4 (current) & 4 (partition)
## increment partition_idx (4+1)
# is 38 < 39? yes
## swap idx 5 (current) & 5 (partition)
## increment partition_idx (5+1)
## [12, 16, 27, 39, 27, 38]
# loop over
# swap partition_idx - 1 (5) & pivot position (3)
# [12, 16, 27, 38, 27, 39]
# returns partition_idx - 1 = idx 5, which is the pivot 39
#
# Partition Call #5
# -----------------
# [12, 16, 27, 38, 27, 39]
# called with [38, 27]
# 38 is taken as the pivot at idx 3
# partition_idx is 4
# is 27 < 38? yes
## swap idx 4 and 4
## increment partition_idx (4+1)
# is 38 < 39? no
# loop terminates
# swap partition_idx - 1 (4) and pivot (3)
# [12, 16, 27, 27, 38, 39]
#
# Partition Call #"6" <-- Doesn't make it because `if low < high` fails
# -----------------
# would be called with [27]
# size is 1, necessarily sorted
#
# `partition` is thus actually called a total of 4 times
# (i.e. the `if` block is entered 4 times in total)

# An example using `high` as pivot
def quick_sort(array, low = 0, high = array.size - 1)
  if low < high
    partition_idx = partition(array, low, high)
    quick_sort(array, low, partition_idx - 1)
    quick_sort(array, partition_idx + 1, high)
  end

  array
end

def partition(array, low, high)
  pivot = array[high]
  partition_idx = low

  (low...high).each do |current_idx|
    if array[current_idx] < pivot
      array[partition_idx], array[current_idx] = array[current_idx], array[partition_idx]
      partition_idx += 1
    end
  end

  array[partition_idx], array[high] = array[high], array[partition_idx]
  partition_idx
end

p quick_sort([8, 4, 2, 3, 1, 0, 5, 7, 6])

# Randomized pivot
# https://Visualgo.net/en/sorting?slide=12
def quick_sort(array, low = 0, high = array.size - 1)
  if low < high
    partition_idx = partition(array, low, high)
    quick_sort(array, low, partition_idx - 1)
    quick_sort(array, partition_idx + 1, high)
  end

  array
end

def partition(array, low, high)
  # randomly select a pivot and swap with last element
  # could alternatively swap with first element & then
  # change the other variables as we did above
  random_idx = rand(low..high)
  array[high], array[random_idx] = array[random_idx], array[high]

  pivot = array[high]
  partition_idx = low

  (low...high).each do |current_idx|
    if array[current_idx] < pivot
      array[partition_idx], array[current_idx] = array[current_idx], array[partition_idx]
      partition_idx += 1
    end
  end

  array[partition_idx], array[high] = array[high], array[partition_idx]
  partition_idx
end

p quick_sort([3, 7, 8, 5, 2, 1, 9, 5, 4])

# More:
# https://stackoverflow.com/a/21387864
# Mittag's quick_sort
## `pivot` is a random element isolated from the array each time
## #partition returns 2 arrays, the first with elements for which the block
## evalutes to true, the second with elements for which block evals false
## so we immediately have elements < pivot and elements > pivot available to us
## we can recurse with left and right just as we did above,
## and return an array with the smaller elements sorted, followed by the pivot,
## followed by the larger elements sorted
# it's important to note that if either left or right is empty, recursion returns []

# def foo(*array)
#   array
# end
# # using *array in the block can pass each individually
# p foo(1, 4, 5) # => [1, 4, 5]
# p foo([1, 4, 5]) # => [[1, 4, 5]]

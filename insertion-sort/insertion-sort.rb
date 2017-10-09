# pseudocode (visualgo):
# mark first element as sorted
# for each unsorted element X
#   'extract' the element X
#   for j = lastSortedIndex down to 0
#     if current element j's value > X
#       move over the SORTED element to the right by 1
#     break loop and insert X

# array[i] will represent the unsorted element 'extracted' for comparison to others
# we have to assign it to temp in `temp = array[i]` because we might overwrite at idx i
# array[j] will represent the sorted el being compared, i.e. the last sorted index
# array[j + 1] represents to the element to the right in the sorted subarray
# if temp < array[j], keep checking left! change the array to make room for temp b/c
# we must place a smaller element (the extracted array[i]) before a bigger el soon.
# continue until array[i] > array[j] OR we exhausted all indices at which point
# push the value to the top of the last smaller el OR to the start, if it's the min.
def insertion_sort(array)
  (1...array.size).each do |i|
    value = array[i]
    j = i - 1

    while j >= 0 && array[j] > value
      array[j + 1] = array[j] # shift the value to the right
      j -= 1
    end

    array[j + 1] = value # `j + 1` is equal to `i` if the `while` wasn't entered
  end

  array
end

p insertion_sort([23, 42, 4, 16, 8, 15])

# e.g. [23, 42, 4, 16, 8, 15]
# [23] is taken as the sorted subarray
# 42 is extracted as array[i]
# 42 > 23, so just reset: array[i] = 42
# [23, 42] is the sorted subarray
# 4 is extracted as array[i]
# 4 < 42, so change array to [23, 42, 42, 16, 8, 15]
# then consider the next left index
# 4 < 23, so change array to [23, 23, 42, 16, 8, 15]
# we've reached the final j for the `while` loop (j < 0 now)
# array[j + 1] == array[0] = 4
# note, here you can see why `value = array[i]` is necessary: position where 4 was is 42 now
# [4, 23, 42, 16, 8, 15]
# extract 16 as array[i]
# 16 < 42 -> [4, 23, 42, 42, 8, 15]
# 16 < 23 -> [4, 23, 23, 42, 8, 15]
# 16 > 4 -> fail loop condition -> [4, 16, 23, 42, 8, 15]
# ..repeat..

#
# Time complexity:
# Worst-case: O(n^2)
# in the worst case, we might have to slide the number some number of times
# and every slide is 1 less than the previous
# so we end up with something like (1 + 2 + 3 + 4 + .. + (n-1))
# arithmetic sum progression is on the order of n^2
# thus worst case and average case is O(n^2)

# Best-case: Ω(n) when we are able to skip the `while` loop when array[j] < value
# the insert operation will take constant time because the array was already
# sorted.. so this happens when array[j] < value is true for __every__ check

#
# Space complexity:
# O(1), it's an in-place sort

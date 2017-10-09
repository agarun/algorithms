def selection_sort(array)
  (0..array.size - 2).each do |i|
    min = i

    (i + 1..array.size - 1).each do |j|
      min = j if array[j] < array[min]
    end

    array[i], array[min] = array[min], array[i] if min != i
  end

  array
end

p selection_sort([23, 42, 4, 16, 8, 15])

# [23, 42, 4, 16, 8, 15]
# Set min = 0, pointing to 23
# Found a better min at index 2
# index 2 is not equal to index 0, so swap!
# [4, 42, 23, 16, 8, 15]
# Set min = 1, pointing to 42
# Found a better min at index 4
# index 4 is not equal to index 1, so swap!
# [4, 8, 23, 16, 42, 15]
# Set min = 2, pointing to 23 again
# Found a better min at index 5
# index 5 is not equal to index 2, so swap!
# [4, 8, 15, 16, 42, 23]
# Set min = 3, pointing to 16
# Couldn't find a number less than 16
# index 3 is equal to min (index 3), don't swap.
# [4, 8, 15, 16, 42, 23]
# Set min = 4, pointing to 42
# Found a better min at index 5
# index 5 is not equal to index 4, so swap!
# [4, 8, 15, 16, 23, 42]
# We don't set min to 5 because of the ranges specified
# _because_ there is no need to check the last element,
# since the last sort took care of its position.

#
# Time complexity:
# The number of iterations of the loop begins as n
# then n - 1.. n - 2.. etc
# (n) + (n - 1) + (n - 2) + .. + 2 + 1
# Arithmetic progression sum is (first + last)*(num pairs) = (n + 1)(n / 2)
# which is on the order of n^2
# Calls to find mins + Calls to swap + Loop = O(n^2 + ...) = O(n^2)
# Best-case is still O(n^2) because we'll have to perform these operations every time
# with how the code executes - note that the loop is _always_ entered
# what doesn't always happen is the swap / if statement, which are constant..

#
# Space complexity:
# O(1) - it's in place!

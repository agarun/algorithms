require 'benchmark'

# Perform binary search on a sorted collection of elements (a sorted array)
# Worst & Average Time Complexity O(log n)
# Worst-case Space Complexity O(1)

# Recursive
def binary_search_r(container, item)
  low = 0
  high = container.size - 1

  mid = low + ((high - low) / 2) # prevent overflow issues

  if item < container[mid] # left side
    return binary_search_r(container[low...mid], item)
  elsif item > container[mid] # right side
    return (mid + 1) + binary_search_r(container[mid + 1..high], item)
  else
    return mid
  end
end

# Iterative
def binary_search_i(container, item)
  low = 0
  high = container.size - 1

  while low < high
    mid = low + ((high - low) / 2) # prevent overflow issues

    if item < container[mid]
      high = mid - 1
    elsif item > container[mid]
      low = mid + 1
    else
      return mid
    end
  end

  -1
end

test_num = 5_000_000
test_target = rand(test_num)
test_array = Array.new(test_num) { rand(test_num) }
test_array.sort!

puts "Testing array with #{test_num} elements, looking for #{test_target}."
Benchmark.bm do |bm|
  bm.report do
    binary_search_r(test_array, test_target)
  end
  bm.report do
    binary_search_i(test_array, test_target)
  end
end

# p binary_search_r([0, 2, 3, 4, 9, 11, 12, 12, 14, 15, 22], 15)
# p binary_search_i([0, 2, 3, 4, 9, 11, 12, 12, 14, 15, 22], 4)

# If the input array is unsorted, binary search would be significantly slower
# considering sorting / storing the array (e.g. storing in a Hash, sorting, etc.).
# O( n log n ) worst case is not desirable compared to O( n ).

# If the input array is a rotated array, note that in a rotated array, one half of the
# array is in the correct order. e.g. [2, 3, 4, 5, 1] => 4 is median, the left half is in order.
# 1. Initialize low and high.
# 2. If low > high, the item is not present (return)
# 3. mid = low + ((high - low) / 2)
# 4. If container[mid] == item, return mid
# 5a. If container[low] <= container[mid], the left half is sorted.
# 5b.   If container[low] <= item AND container[mid] >= item, recurse container[low...mid]
# 5b.   Else recurse container[mid + 1..high]
# 5a. Else
# 5c.   If container[high] >= item AND container[mid] <= item, recurse container[mid + 1..high]
# 5c.   Else recurse container[low...mid]
# End

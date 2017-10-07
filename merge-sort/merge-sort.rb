#
# Time Complexity
# Height of tree / number of times we can halve `n` (input) until we reach 1
# is log (n) (the base is 2 in this case)
# This is to say we go `log (n)` levels deep into the recursion
# We do a linear amount of work per level to merge
# This is to say picking the minimum between 2 elements for each element will
# yield (n) work at EACH level
# Thus, in ANY case: (n) * log(n). O(n) = n*log n

#
# Space Complexity
# O(n) because of our `merge` method
# We need to handle storage of the intermediate array that combines `left` and `right`
# so the space complexity is an issue.


# Step 1: Partition elements into groups until n sublists each with 1 element
## Cascade top-down holding onto `merge` calls until each sublist has 1 element
# Step 2: Sort each of the smaller problems recursively into sorted sublists
## We do this by finding the minimum value in the sublists, starting with pairs
## The parent will loop together all pairs, always sorting by the minimum
## of sublists (the minimum is the first element of a sorted sublist)
# Step 3: Final merge of two sorted sublists via the same `merge` procedure

# 1. Top down
# O(log n) sorts
def merge_sort(numbers)
  # Base case
  # Rearrangement is no longer possible, there's only 1 element in `numbers`!
  return numbers if numbers.size == 1

  # Partition unsorted elements into groups
  # Continue until n sublists, each containing 1 element (i.e. all reached base case)
  mid = numbers.size / 2
  left = numbers[0...mid]  # alternatively: numbers.take(mid)
  right = numbers[mid..-1] # alternatively: numbers.drop(mid)

  # Recursively break down sublists into smaller problems
  # until each list has 1 element
  left_nums = merge_sort(left)
  right_nums = merge_sort(right)

  # Merge individual sublists to produce sorted sublists when
  # left_nums && right_nums are available
  merge(left_nums, right_nums)
end

# O(n) merges
def merge(left, right)
  min = []

  # Return the _entire_ array if there's nothing to compare it to
  return left if right.empty?
  return right if left.empty?

  if left.first <= right.first
    min << left.shift
  else
    min << right.shift
  end

  # min is always a sorted sequence
  # merge(left, right) builds min for us until there are no more elements
  # note we must use `+` instead of `<<` because `<<` would create a nested array!
  min + merge(left, right)
end

p merge_sort([5, 9, 7, 12, 1, 3, 6, 8]) # => [1, 3, 5, 6, 7, 8, 9, 12]

# Execution trace for [5, 9, 7, 12, 1, 3, 6, 8]
#
# mid = 8 / 2 = 4
# left = [5, 9, 7, 12]
# right = [1, 3, 6, 8]
# merge_sort(left)
## left = [5, 9]
## right = [7, 12]
## merge_sort(left)
### left = [5] --> RETURN <-- from base case
### right = [9] --> RETURN <-- from base case
#% merge([5], [9]) --> why? because we have returned a valid left_nums && right_nums
#% --> holding left as [5, 9]
## merge_sort(right)
## left = [7] --> RETURN <-- from base case
## right = [12] --> RETURN <-- from base case
#% merge([7], [12])
#% --> holding right as [7, 12]
## wait complete, now we do merge([5, 9], [7, 12])
#% what's smaller - first element of left or first element of right?
#% i.e. what's smaller - 5 or 7? --> 5.
#% so we build a result [5]
#% 7 < 9, result [5, 7]
#% 9 < 12, result [5, 7, 9]
#% left is empty --> [5, 7, 9, 12]
# merge_sort(right) <--> merge_sort([1, 3, 6, 8])
# left = [1, 3]
# right = [6, 8]
# merge_sort(left)
# left = [1] --> RETURN <-- from base case
# right = [3] --> RETURN <-- from base case
#% merge([1], [3])
#% --> holding left as [1, 3]
# merge_sort(right)
# left = [6] --> RETURN <-- from base case
# right = [8] --> RETURN <-- from base case
#% merge([6], [8])
#% --> holding right as [6, 8]
## wait complete, now we do merge ([1, 3], [6, 8])
#% what's smaller - first element of left or first element of right?
#% i.e. what's smaller - 1 or 6? --> 1.
#% so we build a result [1]
#% 3 < 6, result [1, 3]
#% left empty, result [1, 3, 6]
#% left empty, result [1, 3, 6, 8]
# now we have another `left` and `right` that can be deployed to the top of the
# methods we have waiting on the stack
#% i.e. merge([5, 7, 9, 12], [1, 3, 6, 8])
#% employ the same exact merge procedure
#% 1 < 5, result [1]
#% 3 < 5, result [1, 3]
#% 5 < 6, result [1, 3, 5]
#% 6 < 7, result [1, 3, 5, 6]
#% 7 < 8, result [1, 3, 5, 6, 7]
#% 8 < 9, result [1, 3, 5, 6, 7, 8]
#% 9 < 12, result [1, 3, 5, 6, 7, 8, 9]
#% right empty, result [1, 3, 5, 6, 7, 8, 9, 12]
#% --> RETURN <--

# 2. Divide and conquer top-down (no comments, slightly altered)
def merge_sort(numbers)
  return numbers if numbers.size == 1
  mid = numbers.size / 2
  left = numbers[0...mid]
  right = numbers[mid..-1]
  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  if left.empty?
    right
  elsif right.empty?
    left
  elsif left.first <= right.first
    [left.shift] + merge(left, right)
  else # left.first > right.first
    [right.shift] + merge(left, right)
  end
end

p merge_sort([5, 9, 7, 12, 1, 3, 6, 8]) # => [1, 3, 5, 6, 7, 8, 9, 12]

# 3. `merge` without recursion !
# how? because the `until` loop can return `res + left + right` if either the left
# or right arr is empty. in such a case, 2 arrays of 3 are empty, so only the relevant
# array is returned to the cascading recursion. otherwise, .shift() takes care of
# the sorting by mutating the input && ultimately returning a sorted `res`.
def merge_sort(numbers)
  return numbers if numbers.size == 1
  mid = numbers.size / 2
  left = numbers[0...mid]
  right = numbers[mid..-1]
  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  res = []

  until left.empty? || right.empty?
    left.first <= right.first ? res << left.shift : res << right.shift
  end

  res + left + right
end

p merge_sort([5, 9, 7, 12, 1, 3, 6, 8]) # => [1, 3, 5, 6, 7, 8, 9, 12]

# Refs
# Skiena: http://www3.cs.stonybrook.edu/~algorith/video-lectures/2007/lecture8.pdf
# Visuals: https://visualgo.net/en/sorting

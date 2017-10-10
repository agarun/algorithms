# @param {Integer[]} height
# @return {Integer}

# input is "Given n non-negative integers a1.. an"
# n vertical lines drawn (n is how many integers were given, so height.size)

# |
# |
# |
# |
# |
# |
# |    |
# |    |      |
# |    |      |
# |    |      |        |
# |____|______|________|_______________

# find 2 of the lines that when paired with x axis make the max area container
# they form a rectangle right but the heights are different
# let's use the SHORTER line as a length.

# let's use a variable largest to denote the biggest area we found thus far
# initialize largest to 0

# we make 2 indices/pointers:
# the first index 0 is reserved for the first line, so in our height array input
## that would just be index 0
## i = 0

# the last index is reserved for the last line, so in our height array
## that would be height.size - 1
## j = height.size - 1

# we measure the area from line i to line j using the shorter line as length
# and the distance j - i as distance becaus each unit on the axis is 1
## if height[i] > height[j]
##   area = height[j] * (j - i)
## else
##   area = height[i] * (j - i)
## end

# if the area is larger than largest: we 'increment' i by 1
# if the iteration results in a larger area, then we mutate i and record the largest
# if it doesn't, then we keep i as is and 'decrement' j by 1 instead.

def max_area(height)
  largest = 0

  low = 0
  high = height.size - 1

  until low == high
    min = [height[low], height[high]].min
    area = (high - low) * min # area is determined from the shorter length^
    largest = area if largest < area # in case we found a new largest area.

    min == height[low] ? low += 1 : high -= 1 # go inwards from the shorter line
  end

  largest
end

# clarification from:
# https://leetcode.com/problems/container-with-most-water/solution/#approach-2-two-pointer-approach-accepted
#
# initially - consider area between exterior most lines, choosing height from
# the line of shorter length
# maximize - consider area between lines of *larger lengths*
# if we choose to move the pointer at the longer line inwards -> no increase in area
# since it's limited by the shorter line. so, we should move from the shorter line
# inwards because we *might* improve the area, despite having a
# smaller width between the lines
# But moving the shorter line's pointer could turn out to be beneficial,
# as per the same argument, despite the reduction in the width.
# we might even find the longest line this way.
# or a shorter line that is longer than the last shortest line.
# we repeat this logic at every opportunity for such a decision,
# ultimately arriving at the maximized area

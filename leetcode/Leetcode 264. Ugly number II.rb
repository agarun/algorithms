# ugly number must come from some earlier ugly number *2, * 3, or * 5
# simple solution
## keep track of all 3 lists
## the next element is the minimum element from all 3 lists that _isn't_
## already in the sequence we've built
# more efficient:
## keep 3 pointers that can keep track of the position in those 3 lists^
## rather than having to deal with all 3 lists and checking for already existent
## nums, we choose to simply update the pointer when we've already used it
## e.g. all pointers start at 0, once we add the number '6', we should move
## the pointer that we got '6' from forward by 1. we should do this to EVERY
## pointer that was at 6 in case of duplicates! i.e. update ALL pointers.
# note - we should start our ugly_nums sequence with [1] because the problem
# states that it is considered an ugly num.

# @param {Integer} n
# @return {Integer}
def nth_ugly_number(n)
  ugly_nums = [1]

  i = 0
  j = 0
  k = 0

  # loop ends when ugly_nums.size is n
  while ugly_nums.size < n
    by2 = ugly_nums[i] * 2
    by3 = ugly_nums[j] * 3
    by5 = ugly_nums[k] * 5

    min = [by2, by3, by5].min
    ugly_nums << min

    i += 1 if min == by2
    j += 1 if min == by3
    k += 1 if min == by5
  end

  ugly_nums.last
end

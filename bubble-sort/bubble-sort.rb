def bubble_sort(nums)
  # we don't yet know if `nums` is sorted
  sorted = nil

  until sorted
    # we assume `nums` is sorted
    # we enter the `while` loop:
    ## if ary is indeed sorted -> `sorted` is never set to false -> exit both loops
    ## if ary isn't sorted -> reassignment -> re-check the entire new ary
    sorted = true

    i = 0

    while i < nums.size - 1 # `- 1` is necessary to prevent checking past the last el
      if nums[i] > nums[i + 1]
        # an earlier n is greater than a later n -> wrong order -> not sorted!
        sorted = false

        # reassignment
        nums[i], nums[i + 1] = nums[i + 1], nums[i]
      end

      i += 1
    end
  end

  nums
end

p bubble_sort([5, 6, 7, 8, 9, 4, 3, 2])

#
# Time Complexity
#
# O(n^2) and average Θ(n^2) as well. Best case Ω(n).

#
# Space Complexity
#
# O(1)

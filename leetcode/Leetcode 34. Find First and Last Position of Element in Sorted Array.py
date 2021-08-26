def bsearch_first_occurrence(nums, target):
    length = len(nums)
    low = 0
    high = length - 1
    result = -1
    while low <= high:
        mid = floor((low + high) / 2)
        if nums[mid] == target:
            result = mid
            high = mid - 1  # we'll still go through again
        elif nums[mid] < target:
            low = mid + 1
        else:
            high = mid - 1

    return result


class Solution:
    # def searchRange(self, nums: List[int], target: int) -> List[int]:
    #     # bsearch
    #     length = len(nums)
    #     low = 0
    #     high = length - 1
    #     while low <= high:
    #         mid = floor((low + high) / 2)
    #         if nums[mid] == target:
    #             return mid
    #         elif nums[mid] < target:
    #             low = mid + 1
    #         else:
    #             high = mid - 1

    #     return -1

    # nums=[5,7,7,8,8,10]
    # target=8

    def searchRange(self, nums: List[int], target: int) -> List[int]:
        # nums=[5,7,7,8,8,10]
        # target=8

        target_idxs = []

        length = len(nums)
        low = 0
        high = length - 1
        while low <= high:
            mid = floor((low + high) / 2)
            if nums[mid] == target:
                up_delta = 1
                up_done = False
                while not up_done:
                    i = mid + up_delta
                    if i >= length:
                        up_delta -= 1
                        break
                    elif nums[mid + up_delta] == target:
                        up_delta += 1
                    else:
                        up_delta -= 1
                        up_done = True

                down_delta = 1
                down_done = False
                while not down_done:
                    j = mid - down_delta
                    if j < 0:
                        down_delta -= 1
                        break
                    elif nums[mid - down_delta] == target:
                        down_delta += 1
                    else:
                        down_delta -= 1
                        down_done = True

                return [mid - down_delta, mid + up_delta]
            elif nums[mid] < target:
                low = mid + 1
            else:
                high = mid - 1

        return [-1, -1]

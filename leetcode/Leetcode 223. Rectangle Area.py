"""https://leetcode.com/problems/rectangle-area/
https://www.youtube.com/watch?v=zGv3hOORxh0&list=WL&index=6

You're given 2 overlapping rectangles on a plane (2 rectilinear rectangles in a 2D plane.)
For each rectangle, you're given its bottom-left and top-right points
How would you find the area of their overlap? (total area covered by the two rectangles.)
"""


class Solution:
    def computeArea(
        self,
        ax1: int,
        ay1: int,
        ax2: int,
        ay2: int,
        bx1: int,
        by1: int,
        bx2: int,
        by2: int,
    ) -> int:
        bottom_left_1 = [ax1, ay1]
        top_right_1 = [ax2, ay2]
        bottom_right_1 = [ax2, ay1]
        top_left_1 = [ax1, ay2]

        bottom_left_2 = [bx1, by1]
        top_right_2 = [bx2, by2]
        bottom_right_2 = [bx2, by1]
        top_left_2 = [bx1, by2]

        width = 0
        height = 0
        left_3 = max([bottom_left_1[0], bottom_left_2[0]])
        right_3 = min([bottom_right_1[0], bottom_right_2[0]])
        if right_3 > left_3:
            width = abs(right_3 - left_3)

        top_3 = min([top_left_1[1], top_left_2[1]])
        bottom_3 = max([bottom_left_1[1], bottom_left_2[1]])
        if top_3 > bottom_3:
            height = abs(bottom_3 - top_3)

        area_1 = abs(bottom_right_1[0] - bottom_left_1[0]) * abs(
            top_left_1[1] - bottom_left_1[1]
        )
        area_2 = abs(bottom_right_2[0] - bottom_left_2[0]) * abs(
            top_left_2[1] - bottom_left_2[1]
        )
        print(area_1, area_2, width, height)
        return (area_1 + area_2) - (width * height)

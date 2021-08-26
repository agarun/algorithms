class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        m = len(matrix[0])
        n = len(matrix)

        # boundaries
        top = 0
        bottom = n - 1
        left = 0
        right = m - 1

        out = []
        curr_dir = "right"

        while len(out) < m * n and top <= bottom and left <= right:
            if curr_dir == "right":
                for i in range(left, right + 1):
                    out.append(matrix[top][i])
                top += 1
                curr_dir = "down"
            elif curr_dir == "down":
                for i in range(top, bottom + 1):
                    out.append(matrix[i][right])
                right -= 1
                curr_dir = "left"
            elif curr_dir == "left":
                for i in range(right, left - 1, -1):
                    out.append(matrix[bottom][i])
                bottom -= 1
                curr_dir = "up"
            elif curr_dir == "up":
                for i in range(bottom, top - 1, -1):
                    out.append(matrix[i][left])
                left += 1
                curr_dir = "right"
        return out

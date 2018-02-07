# You are given an n x n 2D matrix representing an image.
#
# Rotate the image by 90 degrees (clockwise).
#
# Note:
# You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.
#
# Example 1:
#
# Given input matrix =
# [
#   [1,2,3],
#   [4,5,6],
#   [7,8,9]
# ],
#
# rotate the input matrix in-place such that it becomes:
# [
#   [7,4,1],
#   [8,5,2],
#   [9,6,3]
# ]

# @param {Integer[][]} matrix
# @return {Void} Do not return anything, modify matrix in-place instead.
def rotate(matrix)
  i = 0
  while i < matrix.length - 1
    (i...matrix.length).each do |j|
      matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    end
    i += 1
  end

  i = 0
  while i < matrix.length
    (0...matrix.length / 2).each do |swap_idx|
      matrix[i][swap_idx], matrix[i][-swap_idx - 1] = matrix[i][-swap_idx - 1], matrix[i][swap_idx]
    end
    i += 1
  end
end

def rotate(matrix)
  matrix.reverse!
  i = 0
  while i < matrix.length - 1
    (i...matrix.length).each do |j|
      matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    end
    i += 1
  end
end

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# worst case time & space complexity is O(n)
# @param {TreeNode} root
# @return {TreeNode}
def invert_tree(root)
  return if root.nil?

  inverted_left = invert_tree(root.left)
  inverted_right = invert_tree(root.right)

  root.left = inverted_right
  root.right = inverted_left

  root
end

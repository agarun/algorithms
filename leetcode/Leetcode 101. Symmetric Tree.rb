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
# @return {Boolean}
def is_symmetric(root)
  root.nil? || mirror_image?(root.left, root.right)
end

def mirror_image?(node1, node2)
  return true if node1.nil? && node2.nil?
  return false if node1.nil? || node2.nil?

  node1.val == node2.val &&
    mirror_image?(node1.left, node2.right) &&
    mirror_image?(node1.right, node2.left)
end

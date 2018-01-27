# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {Integer} k
# @return {Integer}
def kth_smallest(root, k)
  arr = in_order_traversal(root)
  arr[k - 1]
end


def in_order_traversal(tree_node, arr = [])
  return if tree_node.nil?

  in_order_traversal(tree_node.left, arr)
  arr << tree_node.val
  in_order_traversal(tree_node.right, arr)

  arr
end

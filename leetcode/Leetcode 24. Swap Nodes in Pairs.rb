# Given a linked list, swap every two adjacent nodes and return its head.
#
# For example,
# Given 1->2->3->4, you should return the list as 2->1->4->3.
#
# Your algorithm should use only constant space. You may not modify the values in the list, only nodes itself can be changed.

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {ListNode}

# swap the nodes themselves:
def swap_pairs(head)
  current_node = head
  until current_node.nil? || current_node.next.nil?
    first = current_node
    second = current_node.next

    first.next = first.next.next
    second.next = first

    head = second if head == current_node
    current_node = current_node.next
    first.next = first.next.next if first.next && first.next.next
  end

  head
end

# swap the values of the nodes:
def swap_pairs(head)
    swap(head)
    head
end

def swap(node)
    return if node.nil? || node.next.nil?

    new_val = node.next.val
    node.next.val = node.val
    node.val = new_val

    swap(node.next.next)
end

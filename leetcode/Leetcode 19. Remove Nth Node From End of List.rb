# Given a linked list, remove the nth node from the end of list and return its head.
#
# For example,
#
#    Given linked list: 1->2->3->4->5, and n = 2.
#
#    After removing the second node from the end, the linked list becomes 1->2->3->5.
# Note:
# Given n will always be valid.
# Try to do this in one pass.

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @param {Integer} n
# @return {ListNode}
def remove_nth_from_end(head, n)
  sentinel = ListNode.new('sentinel')
  sentinel.next = head
  slow = sentinel
  fast = sentinel

  (n + 1).times { fast = fast.next }

  until fast.nil?
    fast = fast.next
    slow = slow.next
  end

  slow.next = slow.next.next
  sentinel.next
end

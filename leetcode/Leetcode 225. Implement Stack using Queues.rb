# Implement the following operations of a stack using queues.
#
# push(x) -- Push element x onto stack.
# pop() -- Removes the element on top of the stack.
# top() -- Get the top element.
# empty() -- Return whether the stack is empty.
#
# Notes:
#
# You must use only standard operations of a queue --
# which means only push to back, peek/pop from front, size,
# and is empty operations are valid.
#
# Depending on your language, queue may not be supported natively.
# You may simulate a queue by using a list or deque (double-ended queue),
# as long as you use only standard operations of a queue.
# You may assume that all operations are valid
# (for example, no pop or top operations will be called on an empty stack).

class MyStack
  def initialize
    @queue_1 = []
    @queue_2 = []
  end

  # O(1) time complexity
  def push(x)
    @queue_1 << x
  end

  # queues are FIFO - first in, first out
  # last el in can only be taken out after all others have been removed
  def pop
    until @queue_1.size == 1
      @queue_2 << @queue_1.shift
    end

    # popped_element = @queue_1.shift
    # @queue_1 = @queue_2
    # @queue_2 = []
    # popped_element

    # ..is the same as..

    # q1 has 1 el, q2 has the rest. we want q2 empty, q1 full - last
    @queue_1, @queue_2 = @queue_2, @queue_1
    @queue_2.shift
  end

  def top
    top_element = @queue_1.pop
    @queue_1 << top_element
    top_element
  end

  def empty
    @queue_1.empty?
  end
end

# Your MyStack object will be instantiated and called as such:
# obj = MyStack.new
# obj.push(x)
# param_2 = obj.pop
# param_3 = obj.top
# param_4 = obj.empty

# Implement the following operations of a queue using stacks.
#
# push(x) -- Push element x to the back of queue.
# pop() -- Removes the element from in front of queue.
# peek() -- Get the front element.
# empty() -- Return whether the queue is empty.
#
# Notes:
# You must use only standard operations of a stack -- which means only
# push to top, peek/pop from top, size, and is empty operations are valid.
# Depending on your language, stack may not be supported natively.
# You may simulate a stack by using a list or deque (double-ended queue),
# as long as you use only standard operations of a stack.
# You may assume that all operations are valid
# (for example, no pop or peek operations will be called on an empty queue).

# 1
class MyQueue
  def initialize
    @stack_1 = []
    @stack_2 = []
  end

  # push to the 'back'
  # enqueue -> back [ ... elements ... ] -> front -> dequeue
  # i.e. we enqueue to the back, but dequeue from the front
  def push(x)
    @stack_1 << x
  end

  def pop
    until @stack_1.empty?
      @stack_2 << @stack_1.pop
    end

    popped_element = @stack_2.pop

    until @stack_2.empty?
      @stack_1 << @stack_2.pop
    end

    popped_element
  end

  def peek
    until @stack_1.empty?
      @stack_2 << @stack_1.pop
    end

    front_element = @stack_2.last

    until @stack_2.empty?
      @stack_1 << @stack_2.pop
    end

    front_element
  end

  def empty
    @stack_1.empty?
  end
end

# 2: optimization by not actually setting @stack_1 to have els
# and @stack_2 to be empty at all times.
# also note that in this case, we'll have to check if both stacks
# are empty for MyQueue#empty
# TODO: this shortcut won't work if we push more elements in
# `push` will need to check if stack_2 has elements
# if stack_2 has elements, empty stack_2 into stack_1 with .pop,
# only THEN push x into stack_1.
class MyQueue
  def initialize
    @stack_1 = []
    @stack_2 = []
  end

  # push to the 'back'
  # enqueue -> back [ ... elements ... ] -> front -> dequeue
  # i.e. we enqueue to the back, but dequeue from the front
  def push(x)
    @stack_1 << x
  end

  def pop
    # set up @stack_2
    peek

    # last el off stack_2 == front el off queue
    @stack_2.pop
  end

  # we accomplish this 'shortcut' from our first implementation
  # by only changing @stack_2 if it's empty (meaning either all elements
  # are in @stack_1 or they're both empty).
  def peek
    if @stack_2.empty?
      @stack_2 << @stack_1.pop until @stack_1.empty?
    end

    # the last element of the stack is the first (front) of Queue
    @stack_2.last
  end

  def empty
    @stack_1.empty? && @stack_2.empty?
  end
end

# Your MyQueue object will be instantiated and called as such:
# obj = MyQueue.new
# obj.push(x)
# param_2 = obj.pop
# param_3 = obj.peek
# param_4 = obj.empty

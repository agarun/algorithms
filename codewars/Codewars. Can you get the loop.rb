
# 1
def loop_size(node)
  nodes_seen = []

  until nodes_seen.include?(node)
    nodes_seen << node
    node = node.next
  end

  nodes_seen.size - nodes_seen.index(node)
end

# 2: initializes `nodes` with `node` & takes advantage of precedence to compact.
def loop_size(node)
  nodes = [node]
  # shovel operator has higher precedence than assignment
  # - https://ruby-doc.org/core-2.3.4/doc/syntax/precedence_rdoc.html
  nodes << node = node.next until nodes.include?(node.next)
  nodes.size - nodes.index(node.next)
end

# 3: Cycle detection
# -> Hare and tortoise algorithm
# https://en.wikipedia.org/wiki/Cycle_detection#Floyd.27s_Tortoise_and_Hare
def loop_size(node)
  tortoise = hare = node
  cycle_found = false
  loop_count = 0

  while !tortoise.next.nil? && !hare.next.nil? && !hare.next.next.nil?
    # two 'pointers' that move at different speeds
    tortoise = tortoise.next
    hare = hare.next.next

    # the loop is completed once we reach the loop point again
    # we have to `break` before setting `cycle_found = true` to avoid breaking early
    break if tortoise == hare && cycle_found

    # this is true once we've made it inside the cycle and gone round once
    # thus we can start counting how many members the cycle has
    cycle_found = true if tortoise == hare
    loop_count += 1 if cycle_found
  end

  loop_count
end

# From the challenge:
# use this if you want to create your code on you computer
# the class of the node is in the description
def create_chain_for_test(tail_size, loop_size)
  prev_node = start = Node.new
  start.next = start
  return start if loop_size == 1
  (1..tail_size).each do |i|
    prev_node.next = Node.new
    prev_node = prev_node.next
  end
  end_loop = prev_node # <--------------------------
  (1...loop_size).each do |i|
    prev_node.next = Node.new
    prev_node = prev_node.next
  end
  prev_node.next = end_loop
  start
end

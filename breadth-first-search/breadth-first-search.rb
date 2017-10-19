require "set"

class Node
  attr_reader :neighbors, :number

  def initialize(number)
    @neighbors = Set.new
    @number = number
  end
end

class Graph
  # `node_one` and `node_two` are now neighbors
  # they are both `Node` instances, so they should both
  # have one another in their @neighbors sets
  # since this is an undirected, possibly cyclic graph
  def edge_between(node_one, node_two)
    node_one.neighbors << node_two
    node_two.neighbors << node_one
  end
end

# Breadth-first search (BFS) on an undirected graph
#
# pseudocode pulled from wiki, visualgo, Skiena's lectures

def breadth_first_search(graph, source, target = nil)
  # queue: first-in, first-out (FIFO). keeps track of which vertices have already
  # been visited but have not yet been visited from, so we know where to search.
  queue = Queue.new

  # a `Set` instance is a collection of unordered values with no duplicates
  # maintain a list of visited nodes and prevent checking a node more than once
  visited = Set.new

  # shortest path information, if applicable
  meta = {}

  # enqueue the source key (push it to the empty queue)
  queue.enq(source)

  until queue.empty?
    # current node, which we `shift` from the queue
    current = queue.deq

    # print the shortest path if it was found
    return path(source, current, meta) if target && current == target

    # we don't have to keep track of distance here, since we have a method
    # to access each of the node's neighbors. the neighbors are stored in a set.
    # process each neighboring vertex of the current node,
    # i.e. traverse all outgoing edges from the current node.
    current.neighbors.each do |neighbor|
      # if the neighbor node is unvisited, we ignore this edge
      unless visited.include?(neighbor)
        queue.enq(neighbor)
        visited.add(neighbor) # we just enqueued this node, so mark it as visited
        meta[neighbor] = current # record the path (only done once, b/c of `unless`)
      end
    end
  end
end

def path(source, target, meta)
  # retrieve the path to the target node, using the meta hash
  # that was constructed at each iteration of the `each` iteration
  predecessor = target
  result_path = []

  # follow the leads from the back
  until predecessor == source
    result_path << predecessor.number
    predecessor = meta[predecessor]
  end

  # add the source, since now `predecessor == source` is true
  result_path << source.number
  result_path.reverse.join(", ")
end

# example

n0 = Node.new("0")
n1 = Node.new("1")
n2 = Node.new("2")
n3 = Node.new("3")
n4 = Node.new("4")
n5 = Node.new("5")
n6 = Node.new("6")
n7 = Node.new("7")

graph1 = Graph.new
graph1.edge_between(n0, n1)
graph1.edge_between(n1, n2)
graph1.edge_between(n1, n3)
graph1.edge_between(n2, n3)
graph1.edge_between(n3, n4)
graph1.edge_between(n4, n5)
graph1.edge_between(n4, n6)
graph1.edge_between(n5, n7)
graph1.edge_between(n6, n7)
#
# 0 - 1 - 3 - 4 - 5
#     |  /    |   |
#     | /     |   |
#     2       6 - 7
#
puts breadth_first_search(graph1, n1, n4) # => 1, 3, 4
puts breadth_first_search(graph1, n3, n6) # => 3, 4, 6

# time complexity
# with an adjacency list, O(|V| + |E|) because
# we inspect _every_ vertex _once_ (due to visited set) -> |V|
# we explore `k` neighbors for vertex v
## if all vertices are explored, we examine all edges
## & total neighbors of all vertices -> |E|
# TODO: adjacency list

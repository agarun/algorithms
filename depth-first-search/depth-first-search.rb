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

# Depth-first search (BFS) on an undirected graph
#
# Recursion: Implicit stack
class DFS
  attr_accessor :graph, :meta, :visited

  def initialize(graph)
    @graph = graph
    @meta = {}
    @visited = Set.new
  end

  # FIXME: this particular recursive implementation
  # works only with trees (acyclic graphs) because of the DFS#path method
  def depth_first_search_recursive(source)
    visited.add(source)

    source.neighbors.each do |neighbor|
      unless visited.include?(neighbor)
        depth_first_search_recursive(neighbor)
        meta[neighbor] = source
      end
    end
  end

  # Iteration: Explicit stack
  def depth_first_search_iterative(source, target = nil)
    # a `Set` instance is a collection of unordered values with no duplicates
    # maintain a list of visited nodes and prevent checking a node more than once
    visited = Set.new

    stack = []
    stack.push(source)

    until stack.empty?
      current = stack.pop

      return path(source, current) if target && current == target

      current.neighbors.each do |neighbor|
        unless visited.include?(neighbor)
          stack.push(neighbor)
          visited.add(neighbor)
          meta[neighbor] = current
        end
      end
    end
  end

  # DFS spanning tree
  # sequence of vertices from a vertex `target`
  # that is reachable from the source vertex `source`
  def path(source, target)
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

dfsX = DFS.new(graph1)
dfsY = DFS.new(graph1)
dfsZ = DFS.new(graph1)

p dfsX.depth_first_search_iterative(n1, n4) # => 1, 3, 4
p dfsY.depth_first_search_iterative(n3, n6) # => 3, 4, 6

puts "-------"

n1 = Node.new("1")
n2 = Node.new("2")
n3 = Node.new("3")
n4 = Node.new("4")
n5 = Node.new("5")
n6 = Node.new("6")
n7 = Node.new("7")

graph2 = Graph.new
graph2.edge_between(n1, n2)
graph2.edge_between(n1, n3)
graph2.edge_between(n2, n4)
graph2.edge_between(n2, n5)
graph2.edge_between(n3, n6)
graph2.edge_between(n3, n7)

dfsA = DFS.new(graph2)
dfsB = DFS.new(graph2)
dfsC = DFS.new(graph2)

p dfsA.depth_first_search_iterative(n1, n7) # => 1, 3, 7
p dfsB.depth_first_search_iterative(n1, n4) # => 1, 2, 4

puts  "Recursive:"
dfsC.depth_first_search_recursive(n1)
p dfsC.path(n1, n7)
p dfsC.path(n1, n4)

# time complexity:
# with an adjacency list, O(|V| + |E|) because
# each vertex is visited at most once because the search will only
# recursively explore the vertex if it's unvisited
# when a vertex is visited, all niehgbors are explored, thus
# when we finish exploring all vertices, we examine E edges

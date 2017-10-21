// Breadth-first search (DFS)

class Graph {
  constructor(nodes = []) {
    this.nodes = nodes;
    this.neighbors = new Array(nodes).fill().map(() => []);
    this.visited = new Array(nodes).fill().map(() => false);
    this.parents = new Array(nodes).fill().map(() => null);
  }

  edgeBetween(nodeOne, nodeTwo) {
    // create an adjacency list to record edges between nodes
    this.neighbors[nodeOne].push(nodeTwo);
    this.neighbors[nodeTwo].push(nodeOne);
  }
};

class DepthFirstSearch {
  constructor(graph, source, target) {
    this.source = source;
    this.target = target;
    this.graph = graph;
  }

  searchRecursive(currentNode = this.source) {
    if (currentNode === this.target) return this.path(currentNode);

    this.graph.visited[currentNode] = true;

    let neighbors = this.graph.neighbors[currentNode];
    for (let i = 0; i < neighbors.length; i += 1) {
      let neighbor = neighbors[i];
      if (this.graph.visited[neighbor] === false) {
        this.graph.parents[neighbor] = currentNode;
        this.searchRecursive(neighbor);
      }
    }
  }

  searchIterative() {
    const graph = this.graph;
    const source = this.source;
    const target = this.target;
    let stack = [source];

    while (stack.length) {
      let currentNode = stack.pop();

      if (currentNode == target) return this.path(currentNode);

      let neighbors = graph.neighbors[currentNode];
      for (let i = 0; i < neighbors.length; i += 1) {
        let neighbor = neighbors[i];
        if (!graph.visited[neighbor]) {

          stack.push(neighbor);
          graph.visited[neighbor] = true;
          graph.parents[neighbor] = currentNode;
        }
      }
    }
  }

  path(currentNode) {
    let path = [];
    let predecessor = currentNode;

    while (predecessor !== this.source) {
      path.push(predecessor);
      predecessor = this.graph.parents[predecessor];
    }

    return path.concat(predecessor).reverse();
  }
};

const graphOne = new Graph(8); // 7 nodes

graphOne.edgeBetween(0, 1);
graphOne.edgeBetween(1, 2);
graphOne.edgeBetween(1, 3);
graphOne.edgeBetween(2, 3);
graphOne.edgeBetween(3, 4);
graphOne.edgeBetween(4, 5);
graphOne.edgeBetween(4, 6);
graphOne.edgeBetween(5, 7);
graphOne.edgeBetween(6, 7);

// 0 - 1 - 3 - 4 - 5
//     |  /    |   |
//     | /     |   |
//     2       6 - 7

// note: not shortest path
// const dfsOne = new DepthFirstSearch(graphOne, 1, 4);
// console.log(dfsOne.searchRecursive());

const graphTwo = new Graph(8); // 7 nodes

graphTwo.edgeBetween(0, 1);
graphTwo.edgeBetween(1, 2);
graphTwo.edgeBetween(1, 3);
graphTwo.edgeBetween(2, 3);
graphTwo.edgeBetween(3, 4);
graphTwo.edgeBetween(4, 5);
graphTwo.edgeBetween(4, 6);
graphTwo.edgeBetween(5, 7);
graphTwo.edgeBetween(6, 7);

// 0 - 1 - 3 - 4 - 5
//     |  /    |   |
//     | /     |   |
//     2       6 - 7

const dfsTwo = new DepthFirstSearch(graphTwo, 2, 6);
console.log(dfsTwo.searchIterative());

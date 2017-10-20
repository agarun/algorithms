// Breadth-first search (BFS)

// - - - - - - - - - - - - - - - -
// (4) with ES6 classes & constructors syntax
// - - - - - - - - - - - - - - - -

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

class BreadthFirstSearch {
  constructor(graph, source, target) {
    this.source = source;
    this.target = target;
    this.graph = graph;
  }

  search() {
    const graph = this.graph;
    const source = this.source;
    const target = this.target;

    let queue = [source];

    while (queue.length) {
      let currentNode = queue.shift();

      if (currentNode == target) return this.path(currentNode);

      let neighbors = graph.neighbors[currentNode];
      for (let i = 0; i < neighbors.length; i += 1) {
        let neighbor = neighbors[i];
        if (!graph.visited[neighbor]) {
          queue.push(neighbor);
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

const bfsOne = new BreadthFirstSearch(graphOne, 1, 4);
console.log(bfsOne.search());

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

const bfsTwo = new BreadthFirstSearch(graphTwo, 3, 6);
console.log(bfsTwo.search());

// - - - - - - - - - - - - - - - -
// (3) implementation via objects/lists input
// - - - - - - - - - - - - - - - -

// TODO

// - - - - - - - - - - - - - - - -
// (2) implementation via adjacency matrix input
// - - - - - - - - - - - - - - - -

const path = function path(meta, source, target) {
  let predecessor = target
  let result_path = [];

  while (predecessor !== source) {
    result_path.push(predecessor);
    predecessor = meta[predecessor];

  }

  result_path.push(source);
  return result_path.reverse().join(", ");
};

const breadthFirstSearch2 = function breadthFirstSearch(graph, source, target) {
  let meta = []; // to print our output path to the target
  let visited = [];
  let queue = [source];

  while (queue.length) {
    currentNode = queue.shift();
    if (currentNode === target) return path(meta, source, target);

    for (let i = 0; i < graph.length; i += 1) {
      let neighbor = graph[currentNode][i];
      // if this node hasn't been visited before &&
      // this node is a neighbor (adjacent to) the currentNode (value 1),
      // then mark it as visited && build the `meta` array for output
      if (!visited[i] && graph[currentNode][i] && i !== currentNode) {
        meta[i] = currentNode;
        visited[i] = true;
        queue.push(i);
      }
    }
  }

  return "No path found!";
}

console.log("\nAdjacency Matrix");

// https://visualgo.net/en/graphds
const testBFS2 = [
  [0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
  [1, 0, 1, 1, 0, 0, 1, 0, 0, 0],
  [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
  [1, 0, 0, 0, 0, 0, 0, 0, 1, 1],
  [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
];

const performSearch = breadthFirstSearch2(testBFS2, 0, 9); // 0, 7, 9
const performSearch2 = breadthFirstSearch2(testBFS2, 6, 5); // 6, 1, 3, 5
console.log(performSearch);
console.log(performSearch2);
console.log('\n');

// - - - - - - - - - - - - - - - -
// (1) implementation via adjacency list & Queue abstraction from KhanAcademy
// - - - - - - - - - - - - - - - -

// Implement a Queue with JS built-in functions
const Queue = function Queue() {
  // Our queue is just an array
  // JS already has built-ins for dequeue (shift) and enqueue (push)
  this.items = [];
}

Queue.prototype.enqueue = function(object) {
  // Side effect
  this.items.push(object);
};

Queue.prototype.dequeue = function() {
  return this.items.shift();
};

Queue.prototype.isEmpty = function() {
  return this.items.length === 0;
};

const doBFS = function(graph, source) {
  let bfsInfo = [];

  // initialize everything to null
  for (let i = 0; i < graph.length; i += 1) {
    bfsInfo[i] = {
      distance: null,
      predecessor: null
    };
  }

  // assign source a distance of 0
  bfsInfo[source].distance = 0;

  let queue = new Queue();

  // begin queue with source node
  queue.enqueue(source);

  while (!queue.isEmpty()) {
    let currentNode = queue.dequeue();

    // in an adjacency list (arr of arrs), the index represents the node,
    // thus we can access the neighbors of a node by the index, and then
    // we can individually access each neighbor in the array
    for (let j = 0; j < graph[currentNode].length; j += 1) {
      let neighbor = graph[currentNode][j];

      // i.e. if it's unvisited (the distance is `null` if so)
      if (bfsInfo[neighbor].distance === null) {
        bfsInfo[neighbor].distance = bfsInfo[currentNode].distance + 1;
        bfsInfo[neighbor].predecessor = currentNode;
        queue.enqueue(neighbor);
      }
    }
  }

  return bfsInfo;
}

const adjList = [
    [1],
    [0, 4, 5],
    [3, 4, 5],
    [2, 6],
    [1, 2],
    [1, 2, 6],
    [3, 5],
    []
    ];

const bfsInfo = doBFS(adjList, 3);

console.log("KhanAcademy BFS with Adjacency List");
for (let i = 0; i < adjList.length; i++) {
    console.log(("vertex " + i + ": distance = " + bfsInfo[i].distance + ", predecessor = " + bfsInfo[i].predecessor));
}

// time complexity
// with an adjacency list, O(|V| + |E|) because
// we inspect _every_ vertex _once_ (due to visited set) -> |V|
// we explore `k` neighbors for vertex v
// if all vertices are explored, we examine all edges
// & total neighbors of all vertices -> |E|

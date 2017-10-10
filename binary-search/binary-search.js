// Recursive
const binarySearchRecursive = function binarySearch(array, item) {
  const low = 0;
  const high = array.length - 1;
  const mid = Math.floor((low + high) / 2);

  if (array[mid] === item) return mid;
  if (item < array[mid]) {
    return binarySearchRecursive(array.slice(low, mid), item)
  } else {
    // account for the mid index. mid + 1 to ignore mid
    return (mid + 1) + binarySearchRecursive(array.slice(mid + 1), item)
  }
};

console.log(binarySearchRecursive([1, 2, 3, 4, 5, 6, 7, 8], 2));
console.log(binarySearchRecursive([1, 2, 3, 4, 5, 6, 7, 8], 6));
console.log(binarySearchRecursive([1, 2, 3, 4, 5, 6, 7, 8], 7));

// Iterative
const binarySearchIterative = function binarySearch(array, item) {
  let low = 0;
  let high = array.length - 1;

  while (low <= high) {
    const mid = Math.floor((low + high) / 2);
    if (array[mid] === item) return mid;

    if (item > array[mid]) {
      low = mid + 1;
    } else {
      high = mid;
    }
  }
};

console.log(binarySearchIterative([1, 2, 3, 4, 5, 6, 7, 8], 2));
console.log(binarySearchIterative([1, 2, 3, 4, 5, 6, 7, 8], 6));
console.log(binarySearchIterative([1, 2, 3, 4, 5, 6, 7, 8], 7));

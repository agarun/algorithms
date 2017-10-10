
// Lomuto partiion scheme
// Randomized

const swap = function swap(array, indexOne, indexTwo) {
  const temp = array[indexOne];
  array[indexOne] = array[indexTwo];
  array[indexTwo] = temp;
};

const partition = function partition(array, low, high) {
  const randomIndex = Math.floor(Math.random() * (high - low + 1)) + low; // inclusive
  swap(array, randomIndex, high);

  const pivot = array[high];

  let partitionIndex = low;

  for (let i = low; i < high; i += 1) {
    if (array[i] < pivot) {
      swap(array, i, partitionIndex);
      partitionIndex += 1;
    }
  }

  swap(array, high, partitionIndex);
  return partitionIndex;
};

const quickSort = function quickSort(array, low, high) {
  if (low < high) {
    const partitionIndex = partition(array, low, high);
    quickSort(array, low, partitionIndex - 1);
    quickSort(array, partitionIndex + 1, high);
  }

  return array;
};

console.log(quickSort([27, 38, 12, 39, 27, 16], 0, 5));
console.log(quickSort([8, 4, 2, 3, 1, 0, 5, 7, 6], 0, 8));
console.log(quickSort([3, 7, 8, 5, 2, 1, 9, 5, 4], 0, 8));

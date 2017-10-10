// kth smallest

const swap = function swap(array, indexOne, indexTwo) {
  const temp = array[indexOne];
  array[indexOne] = array[indexTwo];
  array[indexTwo] = temp;
};

const partition = function partition(array, low, high) {
  const randomIndex = Math.floor(Math.random() * (high - low + 1)) + low;
  const pivot = array[randomIndex];

  swap(array, randomIndex, high);

  let partitionIndex = low;

  for (let i = low; i < high; i += 1) {
    if (array[i] < pivot) {
      swap(array, i, partitionIndex);
      partitionIndex += 1;
    }
  }

  swap(array, partitionIndex, high);
  return partitionIndex;
};

const quickSelect = function quickSelect(array, low = 0, high = array.length - 1, k) {
  if (low === high) return array[low];

  const partitionIndex = partition(array, low, high);

  if (partitionIndex === k) { // partitionIndex is truly sorted
    return array[k];
  } else if (partitionIndex > k) {
    return quickSelect(array, low, partitionIndex - 1, k);
  } else {
    return quickSelect(array, partitionIndex + 1, high, k);
  }
};

console.log(quickSelect([5, 9, 14, 3, 1, 6, 4, 7, 11], 0, 8, 1));

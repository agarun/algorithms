const insert = function insert(array, index, value) {
  let j = index - 1;

  while (j >= 0 && value < array[j]) {
    array[j + 1] = array[j]
    j -= 1;
  }

  array[j + 1] = value;
  return array;
};

const insertionSort = function insertionSort(array) {
  for (let i = 1; i < array.length; i += 1) {
    array = insert(array, i, array[i])
  }

  return array;
};

console.log(insertionSort([23, 42, 4, 16, 8, 15]));

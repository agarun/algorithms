const selectionSort = function selectionSort(array) {
  const indexAtMinimum = function indexAtMinimum(indexFirstMinimum) {
    let minimum = indexFirstMinimum;

    for (let j = indexFirstMinimum + 1; j < array.length; j += 1) {
      if (array[j] < array[minimum]) minimum = j;
    }

    return minimum;
  };

  const swap = function swap(indexFrom, indexTo) {
    const temp = array[indexFrom];
    array[indexFrom] = array[indexTo];
    array[indexTo] = temp;
  };

  for (let i = 0; i < array.length - 1; i += 1) {
    const minimum = indexAtMinimum(i);
    if (minimum !== i) swap(i, minimum);
  }

  return array;
};

console.log(selectionSort([23, 42, 4, 16, 8, 15]));

// #1 with explanation in Ruby (merge-sort.rb)

// 2
const mergeSort = function mergeSort(numbers) {
  if (numbers.length == 1) return numbers;

  let mid = Math.floor(numbers.length / 2);
  let left = numbers.slice(0, mid);
  let right = numbers.slice(mid);
  let leftNums = mergeSort(left);
  let rightNums = mergeSort(right);

  const merge = function merge(left, right) {
    if (left.length == 0) {
      return right;
    } else if (right.length == 0) {
      return left;
    } else if (left[0] <= right[0]) {
      const min = left.shift();
      return [min].concat(merge(left, right));
    } else {
      const min = right.shift();
      return [min].concat(merge(left, right));
    };
  };

  return merge(leftNums, rightNums);
};

console.log(mergeSort([5, 9, 7, 12, 1, 3, 6, 8])); // => [ 1, 3, 5, 6, 7, 8, 9, 12 ]

// 3
const mergeSortAlt = function mergeSortAlt(numbers) {
  if (numbers.length == 1) return numbers;

  let mid = Math.floor(numbers.length / 2);
  let left = numbers.slice(0, mid);
  let right = numbers.slice(mid);
  let res = [];

  const merge = function merge(left, right) {
    while (left.length && right.length) { // while neither are 0 === until either are 0 (DeMorgan's)
      left[0] <= right [0] ? res.push(left.shift()) : res.push(right.shift());
    }

    return res.concat(left, right);
  };

  return merge(mergeSortAlt(left), mergeSortAlt(right));
};

console.log(mergeSortAlt([5, 9, 7, 12, 1, 3, 6, 8])); // => [ 1, 3, 5, 6, 7, 8, 9, 12 ]

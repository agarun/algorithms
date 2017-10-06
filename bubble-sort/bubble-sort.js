const bubbleSort = function sort(nums) {
  let sorted = null;

  while (!sorted) {
    sorted = true;

    let i = 0;

    while (i < nums.length - 1) {
      if (nums[i] > nums[i + 1]) {
        sorted = false;
        temp = nums[i]
        nums[i] = nums[i + 1]
        nums[i + 1] = temp
      };

      i++;
    };
  };

  return nums;
};

console.log(bubbleSort([5, 6, 1, 3, 9, 8, 7]));

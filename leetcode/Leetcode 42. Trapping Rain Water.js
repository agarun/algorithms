/**
 * Given n non-negative integers representing an elevation
 * map where the width of each bar is 1, compute how much water it can trap after raining.
 *
 * https://leetcode.com/problems/trapping-rain-water/
 * https://www.youtube.com/watch?v=XrsxV0DT6Dg&list=WL&index=5
 */

/**
 * @param {number[]} heights
 * @return {number}
 */
// O(n^2)
var trap = function (heights) {
  let water = 0;

  for (let i = 0; i < heights.length; i++) {
    let leftMax = 0;
    let rightMax = 0;

    // for every point we can find the most water that can fit there
    for (let j = i; j >= 0; j--) {
      leftMax = Math.max(leftMax, heights[j]);
    }

    for (let j = i; j < heights.length; j++) {
      rightMax = Math.max(rightMax, heights[j]);
    }

    let waterHeight = Math.min(leftMax, rightMax);
    water += waterHeight - heights[i]; // - heights[i] to find the amount of water that can fit here
  }

  return water;
};

// what's the repetitive part that makes the above quadratic?
// for every bar you have to check all the way to the left & right

const leftMax = (array) => {
  const max = [array[0]];
  for (let i = 1; i < array.length; i++) {
    max[i] = Math.max(max[i - 1], array[i]);
  }
  return max;
};

const rightMax = (array) => {
  const max = [];
  max[array.length - 1] = array[array.length - 1];
  for (let i = array.length - 2; i >= 0; i--) {
    max[i] = Math.max(max[i + 1], array[i]);
  }
  return max;
};

// O(n)
var trap = function (heights) {
  let water = 0;

  let lefts = leftMax(heights);
  let rights = rightMax(heights);

  for (let i = 0; i < heights.length; i++) {
    let waterHeight = Math.min(lefts[i], rights[i]);
    water += waterHeight - heights[i];
  }

  return water;
};

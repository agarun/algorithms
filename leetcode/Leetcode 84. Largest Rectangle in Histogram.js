/**
 * Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.
 *
 * https://leetcode.com/problems/largest-rectangle-in-histogram/
 * https://www.youtube.com/watch?v=XrsxV0DT6Dg&list=WL&index=5
 */

/**
 * @param {number[]} heights
 * @return {number}
 */
// O(n^3)
var largestRectangleArea = function (heights) {
  let largestArea = 0;

  if (heights.length === 0) {
    return 0;
  } else if (heights.length === 1) {
    return heights[0];
  }

  // every left pt
  for (let left = 0; left < heights.length; left++) {
    // every possible right pt -> create every possible interval
    largestArea = Math.max(heights[left], largestArea);
    for (let right = left + 1; right < heights.length; right++) {
      // the min will be a height
      let min = Number.POSITIVE_INFINITY;

      for (let i = left; i <= right; i++) {
        min = Math.min(min, heights[i]);
      }

      let area = min * (right - left + 1);
      largestArea = Math.max(area, largestArea);
    }
  }

  return largestArea;
};

// diff aproach:
// take each bar and see which rectangle can fit in the bar with that bar's height
// iterate over every bar
// check left + right bars, find the first bar that is smaller (min on left & right)
// calculate the area, keep track of the max
// should be quadratic instead of cubic
// O(n^2)
var largestRectangleArea = function (heights) {
  let largestArea = 0;

  if (heights.length === 0) {
    return 0;
  } else if (heights.length === 1) {
    return heights[0];
  }

  // every left pt
  for (let i = 0; i < heights.length; i++) {
    const height = heights[i];

    let left = i - 1;
    while (left >= 0) {
      // >= so both are out of bounds
      if (heights[left] < height) {
        break;
      }
      left -= 1;
    }

    let right = i + 1;
    while (right < heights.length) {
      if (heights[right] < height) {
        break;
      }
      right += 1;
    }
    const area = height * (right - left - 1);
    largestArea = Math.max(area, largestArea);
  }

  return largestArea;
};

// we make note that we repeat some iterations in the O(n^2) approach above
// we repeat the same comparisons to find the same minimum
// e.g. 2,1,3,4,5,6,7,8,2,2,2,2,2,2,2,2,2,2
//        ^ minimum is here, but we have to iterate everything each time to find it

// subproblem:
// given an array of ints, find the nearest smaller number for every element
// such that the smaller number is on the left side
// i.e. we want to generate a small & big (left & right) array, so we have to find the split point

// we note that we can ignore intermediate values once we process them and already find a smaller min height to the left

const nearestSmaller = (array) => {
  const output = [];
  const stack = [];

  const peekStack = () => stack[stack.length - 1];

  for (let i = 0; i < array.length; i++) {
    while (stack.length !== 0 && peekStack() >= array[i]) {
      // if current value is greater than the last value, we'll pop.
      stack.pop(); //
    }

    if (stack.length === 0) {
      output.push(-1);
    } else {
      // this is the last element that meets the condition `peekStack() >= array[i]`
      // so it must be the min that appears before `array[i]`
      output.push(peekStack());
    }

    stack.push(array[i]);
  }
  return output;
};

const nearestSmallerIdxsLeft = (array) => {
  const output = [];
  const stack = [];

  const peekStack = () => stack[stack.length - 1];

  for (let i = 0; i < array.length; i++) {
    while (stack.length !== 0 && array[peekStack()] >= array[i]) {
      stack.pop();
    }

    if (stack.length === 0) {
      output.push(-1);
    } else {
      output.push(peekStack());
    }

    stack.push(i);
  }
  return output;
};

const nearestSmallerIdxsRight = (array) => {
  const output = [];
  const stack = [];
  const peekStack = () => stack[stack.length - 1];
  for (let i = heights.length - 1; i >= 0; i--) {
    while (stack.length !== 0 && heights[peekStack()] >= heights[i]) {
      stack.pop();
    }
    if (stack.length === 0) {
      output.push(heights.length);
    } else {
      output.push(peekStack());
    }
    stack.push(i);
  }
  return output.reverse();
};

// O(3n) == O(n)
var largestRectangleArea = function (heights) {
  if (heights.length === 0) {
    return 0;
  } else if (heights.length === 1) {
    return heights[0];
  }

  let largestArea = 0;
  const leftNearest = nearestSmallerIdxsLeft(heights);
  const rightNearest = nearestSmallerIdxsRight(heights);

  for (let i = 0; i < heights.length; i++) {
    const height = heights[i];
    const left = leftNearest[i];
    const right = rightNearest[i];
    const area = height * (right - left - 1);
    largestArea = Math.max(largestArea, area);
  }

  return largestArea;
};

// shortened
var largestRectangleArea = function (heights) {
  heights.push(0); //add a helper bar with 0 height at the end, so there is always a lower bar on the right.
  var stack = [];
  var result = 0;
  var i = 0;
  while (i < heights.length) {
    if (stack.length === 0 || heights[stack[stack.length - 1]] < heights[i]) {
      stack.push(i);
      i++;
    } else {
      var height = heights[stack.pop()]; //the heightest bar in the stack so far.
      var left = stack.length - 1 >= 0 ? stack[stack.length - 1] : -1;
      var width = i - left - 1;
      result = Math.max(result, height * width);
    }
  }
  return result;
};

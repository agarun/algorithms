// using reduce
function digitalRoot(n) {
  while (n > 9) {
    numArray = String(n).split('');
    n = numArray.reduce(function(sum, digit) {
      return sum + Number(digit);
    }, 0);
  }

  return n;
};

// iterative digitalRootSum
function digitalRoot(n) {
  const digitalRootSum = function digitalRootSum(num) {
    let sum = 0;

    while (num.length > 0) {
      sum += Number(num[0]);
      num = num.slice(1);
    }

    return sum;
  };

  let result = n;
  while (String(result).length > 1) {
    result = digitalRootSum(String(result));
  }
  return result;
};

// recursive digitalRootSum
function digitalRoot(n) {
  const digitalRootSum = function digitalRootSum(num) {
    if (num.length == 1) {
      return Number(num);
    } else {
      head = Number(num[0]);
      tail = num.slice(1);
    }
    return head + digitalRootSum(tail);
  };

  let result = n;
  while (String(result).length > 1) {
    result = digitalRootSum(String(result));
  }
  return result;
};

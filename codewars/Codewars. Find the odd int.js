function findOdd2(array) {
  let object = {};

  array.forEach(function(element) {
    object[element] ? object[element] += 1 : object[element] = 1;
  });

  for (n in object) {
    if (object[n] % 2 !== 0) return Number(n); // without Number(), rets as str
  }
};

function findOdd(array) {
  const count = function(array, element) {
    let total = 0;
    for (let i = 0; i < array.length; i += 1) {
      if (array[i] === element) total += 1;
    }
    return total;
  };

  const chosenOne = array.filter(function(n) {
    if (count(array, n) % 2 !== 0) return n;
  });

  return chosenOne[0];
};

// You live in the city of Cartesia where all roads are laid out in a
// perfect grid. You arrived ten minutes too early to an appointment,
// so you decided to take the opportunity to go for a short walk.
// The city provides its citizens with a Walk Generating App on their
// phones -- everytime you press the button it sends you an array of
// one-letter strings representing directions to walk (eg. ['n', 's', 'w', 'e'])
//
// You know it takes you one minute to traverse one city block, so create a
// function that will return true if the walk the app gives you will take
// you exactly ten minutes (you don't want to be early or late!) and will, of
// course, return you to your starting point. Return false otherwise.
//
// Note: you will always receive a valid array containing a random assortment
// of direction letters ('n', 's', 'e', or 'w' only). It will never give
// you an empty array (that's not a walk, that's standing still!).

function isValidWalk(walk) {
  if (walk.length !== 10) return false;

  const axis =  {
    n: 0, s: 0, e: 0, w: 0
  };

  walk.forEach((dir) => {
    axis[dir] += 1;
  });
  return axis.n === axis.s && axis.e === axis.w
};

function isValidWalk(walk) {
  if (walk.length !== 10) return false;

  const axis = {
    'n': 1,
    's': -1,
    'e': 1,
    'w': -1
  }

  let progress = 0;

  walk.forEach(function(dir) {
    progress += axis[dir];
  });

  return progress === 0;
};

// you can also use this concept & use `switch` with `case` instead
// instead of n/s/e/w, just have `x` and `y` in axis,
// then increment or decrement based on the case (which letter it is),
// return true if both axes equal to 0

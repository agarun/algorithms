
const totalCombos = function(target) {
  const coins = [1, 2, 5, 10, 20, 50, 100, 200];
  let comboCount = 0;

  const coinCombos = function(remainder, i) {
    if (i === 0 && remainder % coins[i] === 0) {
      return comboCount++;
    }

    while (remainder >= 0) {
      coinCombos(remainder, i - 1);
      remainder -= coins[i]
    }
  };

  coinCombos(target, coins.length - 1);
  return comboCount;
};

console.log(totalCombos(200));

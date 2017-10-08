# CTCI Chapter 8 Q 11
# Coins: Given an infinite number of quarters (25 cents), dimes (1O cents),
# nickels (5 cents), and pennies (1 cent), write code to calculate the number of
# ways of representing n cents.


# 2 - Memoization of the subproblems
# Memoizing the fact that we repeat calls for the same `amount` & `idx`
def coin_change(coins, amount)
  make_change(coins, amount, 0, {})
end

def make_change(coins, amount, idx, memo)
  # if we're out of money or we reached the end
  return 1 if amount == 0 || idx >= coins.size

  current_coin = coins[idx]
  change_so_far = 0
  combos = 0

  key = "#{amount}::#{idx}" # some way to store access to `amount` & `idx`
  return memo["#{amount}::#{idx}"] if memo.key?(key)

  while change_so_far <= amount
    remaining = amount - change_so_far
    combos += make_change(coins, remaining, idx + 1, memo) # idx + 1 is the next coin
    change_so_far += current_coin
  end

  memo[key] = combos
  combos
end

p coin_change([1, 5, 10, 25], 100)

# 1 - Basic recursion
def coin_change(coins, amount)
  make_change(coins, amount, 0)
end

def make_change(coins, amount, idx)
  # if we're out of money or we reached the end
  return 1 if amount == 0 || idx >= coins.size

  current_coin = coins[idx]
  change_so_far = 0
  combos = 0

  while change_so_far <= amount
    remaining = amount - change_so_far
    combos += make_change(coins, remaining, idx + 1) # idx + 1 is the next coin
    change_so_far += current_coin
  end

  combos
end

p coin_change([1, 5, 10, 25], 100)

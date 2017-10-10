
# In England the currency is made up of pound, £, and pence, p,
# and there are eight coins in general circulation:
#
# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
# It is possible to make £2 in the following way:
# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
# Q: How many different ways can £2 be made using any number of coins?

# 1: Brute force
def num_combos(target)
  coins = [1, 2, 5, 10, 20, 50, 100, 200]
  combos = 0
  t = target

  t.step(0, -coins[7]) do |a|
    a.step(0, -coins[6]) do |b|
      b.step(0, -coins[5]) do |c|
        c.step(0, -coins[4]) do |d|
          d.step(0, -coins[3]) do |e|
            e.step(0, -coins[2]) do |f|
              f.step(0, -coins[1]) do |g|
                combos += 1
              end
            end
          end
        end
      end
    end
  end

  combos
end

p num_combos(200) # 200 pence

# 2: Recursion
# We can use recursion to count combinations of coins that adds up to target

COINS = [1, 2, 5, 10, 20, 50, 100, 200].freeze

def coin_combos(target, i = COINS.size - 1)
  combos_count = 0

  # -- base case --
  # `i == 0` refers to when recursion has checked every coin
  # `target % current_coin == 0` is our identifier for target being reached
  # further, it refers to when following the recursion through the `COINS` array
  # with a unique sequence of coins has correctly produced the target
  # --> "`if` we checked the coins AND this coin seq does bring us to initial target"
  if i == 0 && target % COINS[i] == 0
    # explicitly return 1 to indicate a unique, valid sequence was found
    return 1
  end

  # -- recursion/generation --
  # when target >= 0, we have yet more coins to add and see if we have a valid seq
  # `>=` so that we can enter the base case after adjusting the remainder (target)
  while target >= 0
    # `i - 1` because we want to check/build seq with the next coin to see if its valid
    combos_count += coin_combos(target, i - 1)

    # note that target -= COINS[i] in each recursion
    # so first we see target is sent to coin_combos as 200,
    # then when it returns, it's sent as 199 (returns 0), 198 (returns 1), etc.
    # when the recursion following `1` completes, the next coin is `5`
    # so it returns 1 on 200, 195..
    target -= COINS[i]
  end

  combos_count
end

# e.g.
p coin_combos(200)

# first recursion will perform `coin_combos(200, 7 - 1)`
# when we _enter_ this method with arguments 200 and 6, we keep recursing
# i.e. our combos_count will be 0 while i changes (reps 100, 50, 20, 10, 5, 2, then 1 at i 1)
# once i is 0, `200 % 1` is 200 so we found a valid sequence via COINS[0] == 1
# we add 1 to combos_count in the `while` loop
# we can then check 199.. which fails (0).. 198 passes (1).. & on and on

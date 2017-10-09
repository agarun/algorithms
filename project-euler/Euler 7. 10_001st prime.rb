# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
# we can see that the 6th prime is 13.
#
# What is the 10 001st prime number?

# We shouldn't test even numbers, because all even number are divisible by 2.

def prime(number)
  counter = 2
  prime_counter = 0

  while prime_counter < 10001
    if prime?(counter)
      prime = counter
      prime_counter += 1
    end

    counter += 1
  end

  prime
end

def prime?(n)
  (2..Math.sqrt(n)).each { |i| return false if n % i == 0 } # short circuits
end

p prime(10001)

# Sieve of Erastosthenes

# 1. Create array of numbers from 0 to n
# 2. Start at 2, delete every multiple of 2 from the array
# 3. Delete every multiple of 3.. and on until sqrt n
# 4. Compact original array

def sieve(limit)
  primes = (0..limit).to_a
  primes[0..1] = nil, nil

  (2..Math.sqrt(limit)).each do |i|

    if primes[i]
      (0..limit).each do |j|
        # start enum from i**2 because 0, 1 are nil and 2, 3 are prime. 2**2 isn't
        # otherwise we'd have to do `(2..limit)` and i*j so 2*2 reaches 4, 2*3 reaches 6, etc.
        # or alternatively something like `(i**2).step(limit, i) { |j| primes[j] = nil }`
        # without i**2 however, we'll be revisiting some numbers we already set `nil`
        primes[i**2 + i * j] = nil
      end
    end

    break if primes.size
  end

  primes.compact
end

p sieve(10_000) # under 100 ms

# Sieve of Erat-ish with Euler 7.
def primes(limit)
  # Upper bound via prime number theorem
  upper_bound = limit * Math.log(limit) + limit * Math.log(Math.log(limit))
  primes = (0..upper_bound).to_a
  primes[0..1] = nil, nil

  (2..Math.sqrt(upper_bound)).each do |i|

    if primes[i]
      (0..upper_bound).each do |j|
        # start enum from i**2 because 0, 1 are nil and 2, 3 are prime. 2**2 isn't
        # otherwise we'd have to do `(2..upper_bound)` and i*j so 2*2 reaches 4, 2*3 reaches 6, etc.
        # or alternatively something like `(i**2).step(upper_bound, i) { |j| primes[j] = nil }`
        # without i**2 however, we'll be revisiting some numbers we already set `nil`
        primes[i**2 + i * j] = nil
      end
    end
  end

  primes.compact[limit - 1]
end

p primes(10_001)

# Refs, post:
# https://math.stackexchange.com/questions/1257/is-there-a-known-mathematical-equation-to-find-the-nth-prime
# Implementation of this in Ruby will be much faster?:
# https://codereview.stackexchange.com/questions/151095/get-nth-prime-number-using-sieve-of-eratosthenes

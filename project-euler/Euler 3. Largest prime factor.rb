# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

# We can produce prime factorization backwards:
# Say we want to find the largest prime factor of 539
# We can start bottom up -
# (Skip 1, it's not a prime factor)
# Is 539 divisible by 2? --> 539 % 2 == 0 --> false
# Is 539 divisible by 3? --> 539 % 3 == 0 --> false
# Odds only because 2 is the only even prime
# Is 539 divisible by 5? --> 539 % 5 == 0 --> false
# Is 539 divisible by 7? --> 539 % 7 == 0 --> true
# Since 539 / 7 is the integer & whole num 77, our problem is reduced.
# Now, we just have to find the largest prime factor of 77.
# Is 77 divisible by 7? --> 77 % 7 == 0 --> true
# 77 / 7 is 11, so we have to find the largest prime factor of 11.
# 11 is a prime factor, so it's its own largest prime factor...
# since we only move i if i is less than square root of n, now we fail
# the condition. we end at 11,
# so we factorized 539 into 7 * 7 * 11

# question - why is this guaranteed to end at primes?

# some value `i` divides the original number `n` if and only if
# `i` is necessarily prime. we only find factors (satisfied the condition `n % i == 0`),
# and we know that the smallest factor of an integer is prime. since we know the first `i` was
# the _smallest_ factor for the original number, the same case will apply to
# the integers we generate from dividing in `n = n / i`, and thus every single `i`
# we encounter must be a prime number.

# our ending condition allows us to terminate when we can't find factors (`i`) anymore
# if we can't find factors anymore, our last possible division by a prime `i`
# produces (1) a largest factor `n`, and (2) a prime `n`, since prime factorization is complete

def largest_prime_factor(n)
  i = 2

  # we only have to go up to sqrt of n, since the largest factor
  # of n could be at MOST sqrt(n) since sqrt(n) * sqrt(n) = n
  while i < Math.sqrt(n)

    if n % i == 0 # if it's a factor
      n = n / i   # then set n to the integer result
      next        # don't increment i, still need to check at i, but not less.
    end

    i == 2 ? i += 1 : i += 2 # if i is 2, go to 3, else go to next odd number
  end

  n
end

p largest_prime_factor(9282)
p largest_prime_factor(600851475143)

# brute force, time taken would be _ages_ !
def largest_prime_factor(n)
  n.downto(1).each do |digit|
    return digit if factor?(digit, n) && prime?(n)
  end
end

def prime?(n)
  (2...Math.sqrt(n)).none? { |num| n % num == 0 }
end

def factor?(digit, n)
  digit % n == 0
end

# p largest_prime_factor(600851475143)

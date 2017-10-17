# If we list all the natural numbers below 10 that are multiples of 3 or 5,
# we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

# sum of numbers (e.g. 1+2+3...) up to n is:
# n(n + 1) / 2
# sum of multiples of k (e.g. 1k+2k+3k...) up to n is thus:
# k * ((n / k)(n / k + 1) / 2)

# why (n / k)? e.g. consider: 3 + 6 + 9 -> 3(1 + 2 + 3)
# so 3 * (1+2+3..) and we know p(p+1)/2 is the sum of (1+2+3..).. then.. note
# that p(p+1)/2 for (1+2+3..999) is 3q(q+1)/2  where q = p/3  for 3(1+2+3..33)

# O(1)
# note: change n to (number - 1) because we need multiples __BELOW__ number
def solution(number)
  mul3 = (number - 1) / 3
  mul5 = (number - 1) / 5
  mul15 = (number - 1) / 15

  (3 * mul3 * (mul3 + 1) + 5 * mul5 * (mul5 + 1) - 15 * mul15 * (mul15 + 1)) / 2
end

# slower but clearer solutions
def solution(number)
  ans = 0
  (3...number).step(3) {|n| ans += n}
  (5...number).step(5) {|n| n % 3 == 0 ? next : ans += n}
  return ans
end

def solution(number)
  (1...number).select { |n| n % 3 == 0 || n % 5 == 0 }.reduce(0, :+)
end

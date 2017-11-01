# Create a function that takes a Roman numeral as its argument and returns its value as a numeric decimal integer. You don't need to validate the form of the Roman numeral.
#
# Modern Roman numerals are written by expressing each decimal digit of the number to be encoded separately, starting with the leftmost digit and skipping any 0s. So 1990 is rendered "MCMXC" (1000 = M, 900 = CM, 90 = XC) and 2008 is rendered "MMVIII" (2000 = MM, 8 = VIII). The Roman numeral for 1666, "MDCLXVI", uses each letter in descending order.
#
# Example:
#
# solution('XXI') # should return 21

ROMANS = {
  M: 1000, D: 500, C: 100, L: 50, X: 10, V: 5, I: 1
}

def solution(string)
  result = 0

  string.chars.each_with_index do |numeral, i|
    previous = ROMANS[string[i - 1].to_sym]
    current = ROMANS[numeral.to_sym]

    if current <= previous || i == 0
      result += current
    else
      result += current - 2 * previous
    end
  end

  result
end

p solution('XXI') # => 21

NUMERALS = {
  M: 1000, CM: 900, D: 500, CD: 400, C: 100,
  XC: 90, L: 50, XL: 40, X: 10,
  IX: 9, V: 5, IV: 4, I: 1
}

def solution(integer)
  result = 0

  integer.gsub(/#{NUMERALS.keys.join("|")}/i) do |numeral|
    result += NUMERALS[numeral.to_sym]
  end

  result
end

p solution('XXI') # => 21
p solution('LXXIV') # => 74

# alternative to solution 2 from Codewars users solutions:
# first, store the regex expression
# then, scan the `NUMERALS` hash with the stored expression,
# take the arguments `|number, numeral|` where `number` comes from the `scan` result
# and `numeral` comes from `NUMERALS` keys -> add to sum

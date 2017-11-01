# Create a function taking a positive integer as its parameter and returning a
# string containing the Roman Numeral representation of that integer.
#
# Modern Roman numerals are written by expressing each digit separately starting
# with the left most digit and skipping any digit with a value of zero.
# In Roman numerals 1990 is rendered: 1000=M, 900=CM, 90=XC; resulting in MCMXC.
# 2008 is written as 2000=MM, 8=VIII; or MMVIII. 1666 uses each Roman symbol
# in descending order: MDCLXVI.

NUMERALS = {
  M: 1000, CM: 900, D: 500, CD: 400, C: 100,
  XC: 90, L: 50, XL: 40, X: 10,
  IX: 9, V: 5, IV: 4, I: 1
}

def solution(integer)
  NUMERALS.reduce("") do |roman, (numeral, number)|
    while integer >= number
      integer -= number
      roman << numeral.to_s
    end

    roman
  end
end

p solution(1666) # => "MDCLXVI"

def solution(integer)
  # base case
  return "" if integer <= 0

  NUMERALS.each do |numeral, number|
    return numeral.to_s + solution(integer - number) if integer >= number
  end
end

p solution(1666) # => "MDCLXVI"

def solution(integer)
  result = ""
  remainder = integer
  dictionary = NUMERALS.to_hash

  dictionary.map do |numeral, number|
    times, remainder = remainder.divmod(number)
    result << numeral.to_s * times
  end

  result
end

p solution(1666) # => "MDCLXVI"

# Given a digit string, return all possible letter combinations that the number could represent.
#
# A mapping of digit to letters (just like on the telephone buttons) is given below.
#
#
#
# Input:Digit string "23"
# Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
# Note:
# Although the above answer is in lexicographical order, your answer could be in any order you want.

# @param {String} digits
# @return {String[]}
def letter_combinations(inputs)
  make_letter_combos(inputs)
end

def make_letter_combos(inputs, combo = "", combos = [])
  nums_letters = {
    2 => %w[a b c],
    3 => %w[d e f],
    4 => %w[g h i],
    5 => %w[j k l],
    6 => %w[m n o],
    7 => %w[p q r s],
    8 => %w[t u v],
    9 => %w[w x y z]
  }

  if inputs.empty?
    combos << combo unless combo.empty?
    return combos
  end

  current_letters = nums_letters[inputs[0].to_i]
  current_letters.each do |ch|
    make_letter_combos(inputs[1..-1], combo + ch, combos)
  end

  combos
end

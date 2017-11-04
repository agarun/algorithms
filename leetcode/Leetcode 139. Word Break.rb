# Given a non-empty string `s` and a dictionary `wordDict` containing
# a list of non-empty words, determine if s can be segmented into
# a space-separated sequence of one or more dictionary words.
# You may assume the dictionary does not contain duplicate words.
#
# For example, given
# s = "leetcode",
# dict = ["leet", "code"].
#
# Return true because "leetcode" can be segmented as "leet code".

# 1 - dynamic programming with tabulation (filling entries)
def word_break(string, dictionary)
  # some index i in the `table` is false if str[0...i] can't be
  # divided into valid words from the dictionary, otherwise it's true
  # since the state is unknown, default to false
  # `size + 1` to access the last index
  table = Array.new(string.size + 1, false)

  # start at 1 to handle the str[0...i] prefix condition
  (1..string.length).each do |i|
    # if this prefix hasn't been seen based on `i` before (maybe saw from `j`)
    # AND this prefix exists in the dictionary, update table entry
    table[i] = true if !table[i] && dictionary.include?(str[0...i])

    # only enter this block if words can be made from str[0...i]
    if table[i]
      # when: `i == string.length` (last char) and table[i] is true (from above)
      # -> string *can* be segmented -> return true
      return true if i == string.length

      (i + 1..string.length).each do |j|
        table[j] = true if !table[j] && dictionary.include?(str[i...j])
      end

      # when: `j == string.length` (last char) && table[j] is true
      # -> string *can* be segmented -> return true
      return true if j == string.length && table[j]
    end
  end

  # none of the prefixes are in dictionary so `if table[i]` was never entered
  false
end

# 2 - dynamic programming solution with tabulation
def word_break(string, dictionary)
  table = Array.new(string.length + 1, false)
  table[0] = true

  (1..string.length).each do |i|
    (0...i).each do |j|
      if table[j] && dictionary.include?(string[j...i])
        table[i] = true
        break # exit inner loop and increment `i`
      end
    end
  end

  # only true if entire string can be segmented
  table.last
end

# e.g. 'leetcode' with 'leet' and 'code' in dictionary
# [false, false, false, false, false, false, false, false, false] (9)
#
# i: 1 -> dictionary.include? 'l'
# i: 2 -> dictionary.include? 'le', 'e'
# i: 3 -> dictionary.include? 'let', 'et' ,'t'
# i: 4 -> dictionary.include? string[0...4] is 'leet' && j is 0
# -> break inner loop, and update table[4] == true
# i: 5 -> dictionary.include? 'leetc', 'eetc', 'etc', 'tc', 'c'
# i: 6 -> dictionary.include? 'leetco', 'eetco', 'etco', 'tco', 'co', 'o'
# i: 7 -> dictionary.include? 'leetcod', 'eetcod', 'etcod', 'tcod', 'cod', 'od', 'd'
# i: 8 -> dictionary.include? 'leetcode', 'eetcode', 'etcode', 'tcode', 'code'
# -> when j is 4 and i is 8, string[4...8] is 'code', which is found in dictionary
# -> break inner loop and set table[8] = true
# NOTE - Array must have `string.length + 1` elements
# for the array of size 9, index 8 will be last element
# -> return table[8], which was set as true

p word_break("leetcode", ["leet", "code"]) # => true

# brute force
# @param {String} s
# @param {String[]} word_dict
# @return {Boolean}
def word_break(str, word_dict)
  return true if str.empty? # base case

  (0...str.size).each do |i|
    head = str[0..i]
    tail = str[i + 1..-1]

    if word_dict.include?(head)
      return true if word_break(tail, word_dict)
    end
  end

  false
end

p word_break("leetcode", ["leet", "code"]) # => true

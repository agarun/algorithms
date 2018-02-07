# Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
#
# For example, given n = 3, a solution set is:
#
# [
#   "((()))",
#   "(()())",
#   "(())()",
#   "()(())",
#   "()()()"
# ]

# @param {Integer} n
# @return {String[]}

# recursive
def generate_parenthesis(n)
  parens_pairs(n)
end

def parens_pairs(n, open_count = 0, close_count = 0, string = "")
  arr = []

  if string.length == 2 * n
    arr << string
    return arr
  end

  if open_count < n
    arr += parens_pairs(n, open_count + 1, close_count, string + "(")
  end

  if close_count < open_count
    arr += parens_pairs(n, open_count, close_count + 1, string + ")")
  end

  arr
end

# iterative
def generate_parenthesis(n)
  stack = [""]
  arr = []

  until stack.empty?
    string, open_count, close_count = stack.pop
    open_count ||= 0
    close_count ||= 0

    if open_count < n
      string_open = string + "("
      stack << [string_open, open_count + 1, close_count]
    end

    if close_count < open_count
      string_close = string + ")"
      stack << [string_close, open_count, close_count + 1]
    end

    if open_count == n && close_count == n
      arr << string
    end
  end

  arr
end

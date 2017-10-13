# 3. Cleaner + Short circuits
SYMBOLS = { ")" => "(", "}" => "{", "]" => "[" }

def group_check(s)
  stack = []

  s.each_char do |c|
    # if it's an opening bracket, add it to the stack
    # SYMBOLS.key?(c) returns nil if the symbol is a closing bracket - it's not in the hash
    stack << c if SYMBOLS.key?(c)

    # Hash#key
    # Returns the key of an occurrence of a given value. If the value is not found, returns nil.

    # `if SYMBOLS.key(c)` checks if it's a closing bracket -> if so it returns true
    # skips opening brackets (returns nil on .key() operation). if it's a closer
    # but the closer is NOT equal to the last element on the stack then we
    # encounter an error --> return false immediately (short circuit)
    # checking against stack.pop does pop to grab the last element & mutates array
    # this is useful because we still want to clear this pair off the stack when
    # the closer is valid.
    return false if SYMBOLS.key(c) && SYMBOLS.key(c) != stack.pop
  end

  stack.empty?
end

# 2. stack and cases
BRACKETS = { ")" => "(", "}" => "{", "]" => "[" }

def group_check(s)
  s.chars.each_with_object([]) do |symbol, stack|
    case symbol
    when *BRACKETS.values
      stack.push(symbol)
    when *BRACKETS.keys
      return false unless stack.pop == BRACKETS[symbol]
    end
  end.empty?
end

# 1. simple stack
def group_check(string)
  pairs = {
    "(" => ")", ")" => "(",
    "{" => "}", "}" => "{",
    "[" => "]", "]" => "["
  }

  stack = []

  string.each_char do |symbol|
    stack.last == pairs[symbol] ? stack.pop : stack.push(symbol)
  end

  stack.empty?
end

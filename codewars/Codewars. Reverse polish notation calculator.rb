# Your job is to create a calculator which
# evaluates expressions in Reverse Polish notation.
#
# For example expression 5 1 2 + 4 * + 3 -
# (which is equivalent to 5 + ((1 + 2) * 4) - 3 in normal notation)
# should evaluate to 14.
#
# Note that for simplicity you may assume that there are always spaces
# between numbers and operations, e.g. 1 3 + expression is valid, but 1 3+ isn't.
#
# Empty expression should evaluate to 0.
#
# Valid operations are +, -, *, /.
#
# You may assume that there won't be exceptional situations (like stack underflow or division by zero).

OPS = %w[+ - / *]

def calc(expr)
  stack = []
  expr.split.each do |token|
    if OPS.include?(token)
      if stack.size < 2
        raise "Invalid operation: not enough elements"
      else
        # Alternatively, use Ruby's operator methods by performing stack.pop in this context.
        # i.e. (1) Popping two elements off
        #      (2) Call method on left element, pass in right element as argument
        stack = send(token, stack)
      end
    else
      stack << token.to_f
    end
  end

  stack.last || 0
end

def +(stack)
  stack << stack.pop + stack.pop
end

def -(stack)
  stack << -stack.pop + stack.pop
end

def *(stack)
  stack << stack.pop * stack.pop
end

def /(stack)
  stack << (1 / (stack.pop / stack.pop))
end

# other ideas
# - make direct use of `reduce(token)`
# - define lambdas (e.g. `'+' => ->(pair) { pair[0] + pair[1] }`)

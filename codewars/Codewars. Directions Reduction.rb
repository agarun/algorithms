# Write a function dirReduc which will take an array of strings and
# returns an array of strings with the needless directions removed
# (W<->E or S<->N side by side).
#
# The Haskell version takes a list of directions with data
#  Direction = North | East | West | South.
#
# Examples
#
# dirReduc(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]) => ["WEST"]
# dirReduc(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH"]) => []

OPPOSITE = {
  "NORTH" => "SOUTH", "SOUTH" => "NORTH",
  "EAST" => "WEST", "WEST" => "EAST"
}

def dirReduc(array)
  stack = []
  array.each { |dir| OPPOSITE[dir] == stack.last ? stack.pop : stack.push(dir) }
  stack
end

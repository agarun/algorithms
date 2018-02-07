# The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)
#
# P   A   H   N
# A P L S I I G
# Y   I   R
# And then read line by line: "PAHNAPLSIIGYIR"
# Write the code that will take a string and make this conversion given a number of rows:
#
# string convert(string text, int nRows);
# convert("PAYPALISHIRING", 3) should return "PAHNAPLSIIGYIR".

# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(str, num_rows)
  return str if num_rows <= 1
  buckets = Array.new(num_rows) { "" }

  down = true
  i = 0
  str.each_char.with_index do |ch, j|
    if i == num_rows
      down = false
      i -= 1
    end

    if i == 0 && j != 0
      down = true
      i += 1
    end

    if down
      buckets[i] << ch
      i += 1
    else
      i -= 1
      buckets[i] << ch
    end
  end

  buckets.join("")
end

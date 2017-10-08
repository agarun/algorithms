# Print all positive integer solutions to the equation a**3 + b**3 = c**3 + d**3
# where a, b, c, and d are integers between 1 and 1000

# step 1 - brute force
# O(n^3)
def solution1
  n = 1000

  (1..n).each do |a|
    (1..n).each do |b|
      (1..n).each do |c|
        # d = 3rd root of (a**3 + b**3 - c**3)
        d = (a**3 + b**3 - c**3)**(1 / 3)
        print [a, b, c, d] if a**3 + b**3 == c**3 + d**3
      end
    end
  end
end

# p solution1

# step 2 - step 1 is regenerating (c, d) for each (a, b) pair
# to avoid this, hash all (c, d) computations.. and thus (a, b) as well
# hash key is the result of one side of the equation,
# the key's value is every pair that contributes to yield the result
def solution2
  n = 1000

  hsh = Hash.new([])

  (1..n).each do |x|
    (1..n).each do |y|
      hsh[x**3 + y**3] += [x, y]
    end
  end

  hsh.values
end

# p solution2

# the book does the following which is O(n^2) generation but overall
# this is O(n^4) worst case depending on list size because of the printing bit...!
# def solution2
#   n = 1000
#
#   hsh = Hash.new([])
#
#   (1..n).each do |x|
#     (1..n).each do |y|
#       hsh[x**3 + y**3] += [[x, y]]
#     end
#   end
#
#   hsh.each do |value, pairs|
#     pairs.each do |p1|
#       pairs.each do |p2|
#         print p1, p2
#       end
#     end
#   end
# end
#
# p solution2

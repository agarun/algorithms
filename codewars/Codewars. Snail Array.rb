def snail(array)
  output = []

  step = 0
  while !array.empty?
    # we can mutate the array in a snail-like pattern:
    # remove the first row
    # pop all the elements off the last rows in order
    # take the last row, but reverse its elements
    # shift all the elements off the first rows in order, then reverse
    # loop 4 steps, resetting when a cycle is over
    case step
    when 0
      output << array.shift
    when 1
      output << array.map(&:pop)
    when 2
      output << array.pop.reverse
    when 3
      output << array.map(&:shift).reverse
    end
    step += 1
    step = 0 if step > 3
  end

  output.flatten
end

p snail([[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16]])

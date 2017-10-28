class Board
  attr_accessor :grid

  def self.default_grid
    Array.new(3) { Array.new(3) }
  end

  def initialize(grid = self.class.default_grid)
    @grid = grid
  end

  def [](position)
    row, col = position
    grid[row][col]
  end

  def []=(position, mark)
    row, col = position
    grid[row][col] = mark
  end

  def place_mark(position, mark)
    # call on `self` since custom [] and []= call on `@grid`
    self[position] = mark if empty?(position)
  end

  def empty?(position)
    self[position].nil?
  end

  def over?
    grid.all?(&:all?) || winner
  end

  def winner
    grid.each { |row| return row.first if winner?(row) }
    grid.transpose.each { |col| return col.first if winner?(col) }
    diagonals.each_slice(3) { |diag| return diag.first if winner?(diag) }
    nil
  end

  def diagonals
    left_diagonal = [[0, 0], [1, 1], [2, 2]].map { |position| self[position] }
    right_diagonal = [[0, 2], [1, 1], [2, 0]].map { |position| self[position] }
    left_diagonal + right_diagonal
  end

  private

  def winner?(triplet)
    winners = [[:X] * 3, [:O] * 3]
    winners.include?(triplet)
  end
end

# ~ notes
# alternative for #winner
#
# def winner
#   (grid + grid.transpose + diagonals).each do |combo|
#     case combo
#     when %i[X X X]
#       return :X
#     when %i[O O O]
#       return :O
#     end
#   end
#
#   nil
# end

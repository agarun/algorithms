require_relative "ship"

class Board
  ATTACKED = :x

  NUM_STARTING_SHIPS = 6

  SCREEN_MARKS = {
    a: "Aircraft",
    b: "Battleship",
    m: "Mariner",
    d: "Destroyer",
    p: "Patrol boat",
    s: "Small ship",
    x: "X"
  }

  SHIP_SIZES = {
    a: 5, # Aircraft
    b: 4, # Battleship
    m: 3, # Mariner
    d: 3, # Destroyer
    p: 2, # Patrol boat
    s: 1, # Small ship
  }

  attr_reader :grid

  def self.default_grid(n = 10)
    Array.new(n) { Array.new(n) }
  end

  def initialize(grid = self.class.default_grid)
    @grid = grid
  end

  def random_position
    [rand(grid.size), rand(grid.size)]
  end

  def count
    grid.flatten.count { |position| !position.nil? }
  end

  def empty?(position = nil)
    # if the position isn't given, board is empty if game is over!
    position ? self[position].nil? : won?
  end

  def full?
    count == grid.size * grid.first.size
  end

  def won?
    count.zero?
  end

  def [](position)
    row, col = position
    grid[row][col]
  end

  def []=(position, mark)
    row, col = position
    grid[row][col] = mark
  end

  def display
    system("clear") || system("cls")

    # column headers
    print ("\n") + ("\s" * 9)
    (0...grid.size).each { |col_number| print "#{col_number}" + ("\s" * 5) }
    print ("\n") + ("\s" * 9) + ("-" * 59) + ("\n")

    # row headers
    SCREEN_MARKS.default = "."
    grid.each_with_index do |row, row_number|
      print ("\s" * 5) + "#{row_number}\s\s|"
      print row.map { |mark| SCREEN_MARKS[mark][0] }.join("\s" * 5)
      print ("\n") + ("\s" * 8) + ("|\n")
    end
  end
end

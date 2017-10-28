class HumanPlayer
  attr_accessor :mark
  attr_reader :name, :board

  def initialize(name, mark = :X)
    @name = name
    @mark = mark
  end

  def display(board)
    # column identifiers
    puts "\n     | 0 | 1 | 2 |\n ----|---|---|---|"

    board.grid.each_with_index do |row, i|
      # row numbers
      print "   #{i} |"
      row.each { |symbol| print " #{symbol.nil? ? " " : symbol} |" }
      puts "\n ----|---|---|---|"
    end
  end

  def get_move
    print <<~PROMPT + ">> "
      Where do you want to make your mark?
      Enter your choice in the form: row number, column number
    PROMPT

    gets.chomp.split(',').map(&:to_i)
  end
end

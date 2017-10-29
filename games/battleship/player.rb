require_relative "ship"

class HumanPlayer
  attr_reader :name, :board

  def initialize(name = "Jack", board = Board.new)
    @name = name
    @board = board
  end

  def setup(num_starting_ships = Board::NUM_STARTING_SHIPS)
    Board::SHIP_SIZES.each do |ship_symbol, ship_size|
      board.display

      print <<~INSTRUCTIONS

        #{name} can place #{num_starting_ships} more ships on the board.
        Tell me where you'd like to place a ship by entering
        the coordinates in the format: row number, column number

        It's time to place the #{Board::SCREEN_MARKS[ship_symbol]}!
      INSTRUCTIONS

      Ship.place_each_ship(board, ship_size, ship_symbol, self)

      num_starting_ships -= 1
    end
  end

  def get_play
    position = []

    until position.size == 2 && within_range?(position)
      print "What's your play? "
      position = gets.chomp.split(",").map(&:to_i)
    end

    position
  end

  def within_range?(position)
    position.all? { |coord| (0..9).cover?(coord) }
  end
end

class ComputerPlayer
  attr_reader :name, :board

  def initialize(name = "Bot Jill", board = Board.new)
    @name = name
    @board = board
  end

  def setup
    Board::SHIP_SIZES.each do |ship_symbol, ship_size|
      Ship.place_each_ship(board, ship_size, ship_symbol, self)
    end

    puts "\nThe computer's grid was filled with #{Board::NUM_STARTING_SHIPS} battleships."
  end

  def get_play
    play = board.random_position
    play = board.random_position until valid_play?(play)
    play
  end

  def valid_play?(position)
    board[position] != Board::ATTACKED
  end
end

class ComputerPlayer
  attr_accessor :mark
  attr_reader :name, :board

  def initialize(name, mark = :O)
    @name = name
    @mark = mark
  end

  def display(board)
    @board = board
  end

  def get_move
    possible_moves = []

    (0..2).each do |row|
      (0..2).each do |col|
        possible_moves << [row, col] if board.empty?([row, col])
      end
    end

    # if the computer has a winning move, it will explicitly return the move
    # else if it doesn't it can block out one of the opponent's winning moves
    # if neither the computer nor the player have winning moves, choose randomly
    # how to win? https://www.quora.com/Is-there-a-way-to-never-lose-at-Tic-Tac-Toe/answer/Arjun-Subramaniam?srid=3XwYl
    block_moves = []
    possible_moves.each do |position|
      if winner?(position, mark)
        return position
      elsif winner?(position, opposite_mark)
        block_moves << position
      end
    end

    block_moves.empty? ? possible_moves.sample : block_moves.sample
  end

  private

  # assume the nil position is a winner if filled with `mark` - if not, reset it
  def winner?(position, marker)
    board[position] = marker
    case board.winner
    when marker
      board[position] = nil
      true
    else
      board[position] = nil
      false
    end
  end

  def opposite_mark
    ([:X, :O] - [mark]).first
  end
end

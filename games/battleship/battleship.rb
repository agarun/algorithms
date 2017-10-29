require_relative "board"
require_relative "player"

class BattleshipGame
  attr_reader :player_one, :player_two, :board

  def initialize(player_one = HumanPlayer.new, board = player_one.board,
                 player_two = ComputerPlayer.new)
    @player_one = player_one
    @player_two = player_two
    @board = board
  end

  def setup
    player_one.setup
    player_two.setup
  end

  def run
    until board.full?
      switch_players!
      announce_turn
      play_turn
      hit_messages
      sleep(4)
      break if game_over?

      board.display unless player_two.is_a?(ComputerPlayer)
      switch_boards!
    end

    announce_winner
  end

  def switch_players!
    @player_one, @player_two = @player_two, @player_one
  end

  def announce_turn
    puts "\nIt's #{player_one.name}'s turn!\n"
  end

  def play_turn
    position = player_one.get_play
    attack(position)
    puts "\nFiring at tile #{position.join(', ')}..."
  end

  def attack(position)
    @hit = true if ship_at?(position)
    board[position] = Board::ATTACKED
  end

  def ship_at?(position)
    Board::SHIP_SIZES.key?(board[position])
  end

  def hit_messages
    hit_message = (@hit ? "hit" : "miss")
    puts "...it was a #{hit_message}!!\n\nNext move in a second..."
    @hit = false
  end

  def switch_boards!
    @board = (board == player_one.board ? player_two.board : player_one.board)
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def announce_winner
    puts "#{player_one.name} sank the battleship!"
  end
end

def game_type
  choice = nil

  until choice == 1 || choice == 2
    print "Type 1 to play a one-person game against the computer, or\n" +
          "type 2 to play a two-person game with a friend: "

    begin
      choice = gets.chomp.to_i
    rescue => error
      puts "Your choice was unrecognized: #{error}"
      print "Try again: "
      retry
    end
  end

  choice
end

def choose_name(n)
  print "\nEnter a name for player #{n}: "
  gets.chomp
end

if $PROGRAM_NAME == __FILE__
  system("clear") || system("cls")
  print "\nWelcome to Battleship!\n\n"

  player_choice = game_type
  case player_choice
  when 1
    player_one_name = choose_name(1)
    player_two = ComputerPlayer.new
  when 2
    player_one_name, player_two_name = choose_name(1), choose_name(2)
    player_two = HumanPlayer.new(player_two_name)
  end

  player_one = HumanPlayer.new(player_one_name)
  print "\n#{player_one.name} will be playing with #{player_two.name}.\n\nLoading"
  %w[. . . . . . .].each do |period|
    print period
    sleep(0.3)
  end

  battleship = BattleshipGame.new(player_one, player_one.board, player_two)
  battleship.setup
  battleship.run
end

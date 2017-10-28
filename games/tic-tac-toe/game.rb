require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
  end

  def switch_players!
    @player_one, @player_two = @player_two, @player_one
  end

  def current_player
    @player_one
  end

  def run
    play_turn until board.over?
    conclude
  end

  def play_turn
    current_player.display(board)
    puts "Alright #{current_player.name}, it's your turn!\n"

    move = current_player.get_move
    mark = current_player.mark
    board.place_mark(move, mark)

    puts "\n#{current_player.name} placed an #{current_player.mark} on #{move}.\n\n"
    switch_players!
  end

  private

  def conclude
    switch_players!
    current_player.display(board)
    if board.winner.nil?
      puts "Game over!"
    else
      puts "Congratulations! #{current_player.name} won as #{current_player.mark}!"
    end
  end
end

if $PROGRAM_NAME == __FILE__
  print "Please enter your name: "
  name = gets.chomp.strip
  human = HumanPlayer.new(name)
  bot = ComputerPlayer.new("BotTacToe")

  new_game = Game.new(human, bot)
  new_game.run
end

require_relative "display"

class Hangman
  include Display

  attr_reader :guesser, :referee, :board, :lives

  def self.import_dictionary
    File.readlines("dictionary.txt").map(&:strip)
  end

  def initialize(players = {})
    @guesser = players[:guesser]
    @referee = players[:referee]
    @lives = STARTING_LIVES
  end

  # (1) referee chooses a secret word
  # (2) announce & display the length of the secret word to the guesser
  # (3) initialize the board to the proper length
  def setup
    secret_word_length = referee.pick_secret_word
    guesser.register_secret_length(secret_word_length)
    empty_board_setup(secret_word_length)
  end

  def empty_board_setup(length)
    @board = Array.new(length)
  end

  def play
    setup
    take_turn until board.all? || lives.zero?
    conclude
  end

  def take_turn
    display_state
    display_board

    guess = guesser.guess(board)
    matches = referee.check_guess(guess)
    guesser.handle_response(guess, matches)

    matches.any? ? update_board(guess, matches) : @lives -= 1
  end

  def update_board(guess, matches)
    matches.each { |letter| board[letter] = guess }
  end

  def display_state
    puts "#{LIVES[lives]}\n"
  end

  def display_board
    board.each do |letter|
      print letter.nil? ? "\s\s\s\s" : "\s#{letter}\s\s"
    end

    puts <<~UNDERLINES

      #{"=== " * board.size}
       #{(0...board.size).to_a.join("   ") if board.size <= 10}

    UNDERLINES
  end

  def conclude
    display_state
    print "The word was '#{referee.secret_word}.'" if defined?(referee.secret_word)
    abort lives.zero? ? "\nNice try... but he's dead!" : "\nYou saved Hangman!"
  end
end

class HumanPlayer
  attr_reader :secret_word_length

  # REFEREE

  # @return [Number] size of the random word
  def pick_secret_word
    print "\nHow long is your word?\n  >> "
    @secret_word_length = gets.chomp.to_i
  rescue => error
    puts "Error: #{error}\nTry again.\n"
  end

  def check_guess(letter)
    print <<~CHECK_INSTRUCTIONS + "  >> "
      The guess was '#{letter}'
      Was that part of your word?

      If it was, type in every index the letter occurs at, for example: '0, 2'
      If it wasn't, press enter to continue.
    CHECK_INSTRUCTIONS

    until (matches = gets.chomp.split(",").map(&:to_i)).all? { |n| n < secret_word_length }
      print "You can enter something like '0, 1' or hit enter if there were no matches.\nTry again: "
      matches
    end

    matches
  end

  # GUESSER

  def register_secret_length(length)
    puts "\nThe word is #{length} characters long."
  end

  def guess(board)
    print "Make a guess: "
    letter = gets.chomp

    while letter.length != 1 || board.include?(letter)
      print "Try again: "
      letter = gets.chomp
    end

    letter
  end

  def handle_response(letter, matches)
    if matches.empty?
      puts "Woops! You guessed '#{letter}' but it doesn't exist in the word!"
    else
      puts "Your guess was found at: #{matches.join(', ')}"
    end
  end
end

class ComputerPlayer
  attr_reader :candidate_words, :secret_word, :secret_word_length

  def initialize(dictionary = Hangman.import_dictionary)
    @candidate_words = dictionary
  end

  # REFEREE

  # @return [Number] size of the random word
  def pick_secret_word
    @secret_word = candidate_words.sample
    secret_word.length
  end

  def check_guess(letter)
    (0...secret_word.size).select { |i| secret_word[i] == letter }
  end

  # GUESSER

  def register_secret_length(length)
    @secret_word_length = length
    update_candidate_words(length)
  end

  def update_candidate_words(length)
    @candidate_words = candidate_words.reject { |word| word.length != length }
  end

  # returns the most common letter in `candidate_words`
  def guess(board)
    letter_counts = remaining_letters(board)
    most_common_letter(letter_counts)
  end

  def remaining_letters(board)
    letter_counts = Hash.new(0)

    candidate_words.each do |word|
      board.each_with_index do |position, i|
        # if the board spot is empty (no letter here),
        # add the word's letter at this spot to letter counts
        letter_counts[word[i]] += 1 if position.nil?
      end
    end

    letter_counts
  end

  def most_common_letter(letter_counts)
    if letter_counts.empty?
      abort "Ran out of words! It's not in my dictionary =("
    else
      letter_counts.max_by { |letter, letter_count| letter_count }.first
    end
  end

  def handle_response(letter, matches)
    if matches.empty?
      # reject words that have the `letter` at any index
      @candidate_words = candidate_words.reject { |word| word.include?(letter) }
    else
      # select words that have the `letter` ONLY at each index in `matches`
      non_matches = (0...secret_word_length).to_a - matches
      @candidate_words = candidate_words.select do |word|
        matches.all? { |match_i| word[match_i] == letter } &&
        non_matches.all? { |non_match_i| word[non_match_i] != letter }
      end
    end
  end
end

def welcome_message
  system("clear") || system("cls")
  print <<~WELCOME + "  >> "

    Welcome to Hangman!

    Type g if you'd like the computer to choose a word. You'll guess the letters!
    Type c if you'd like the computer to guess your word. You'll tell it how long it is.
    Type 2 if you'd like to play with a friend.
  WELCOME
end

if $PROGRAM_NAME == __FILE__
  welcome_message

  until %w[g c 2].include?(choice = gets.chomp.downcase)
    print "Try again... >> "
    choice
  end

  human = HumanPlayer.new
  computer = ComputerPlayer.new

  case choice
  when "g"
    guesser, referee = human, computer
  when "c"
    guesser, referee = computer, human
  when "2"
    guesser, referee = human, human
  end

  game = Hangman.new(guesser: guesser, referee: referee)
  game.play
end

class Code
   PEGS = {
     RED: "R",
     GREEN: "G",
     BLUE: "B",
     YELLOW: "Y",
     ORANGE: "O",
     PURPLE: "P"
   }

  attr_reader :pegs

  def self.parse(code)
    code = code.upcase.chars

    if valid_code?(code)
      Code.new(code)
    else
      raise "The code had invalid characters. Choose from #{PEGS.values.join}"
    end
  end

  def self.valid_code?(code)
    code.all? { |peg| PEGS.values.include?(peg) } && code.size == 4
  end

  def self.random
    self.new(
      Array.new(4) { PEGS.values.sample }
    )
  end

  def initialize(pegs)
    @pegs = pegs
  end

  def exact_matches(code)
    (0...code.pegs.size).reduce(0) do |exact, idx|
      self.pegs[idx] == code.pegs[idx] ? exact + 1 : exact
    end
  end

  def near_matches(code)
    code1 = self.pegs.dup
    code2 = code.pegs.dup
    total = 0

    (0...code1.size).each do |idx|
      if code1.include?(code2[idx])
        total += 1
        code1[code1.index(code2[idx])] = '0' # mark it so it can't be matched again
      end
    end

    total - exact_matches(code) # near = total matches - exact matches
  end

  # allows you to use `[]` syntax directly on an instance, using `pegs` getter
  def [](peg_index)
    pegs[peg_index]
  end

  def ==(code)
    code.is_a?(Code) && pegs == code.pegs
  end
end

class Game
  TURNS = 10

  attr_reader :secret_code, :turns, :guess

  def initialize(secret_code = Code.random)
    @secret_code = secret_code
    @turns = TURNS
  end

  def get_guess
    print "\n >> "
    Code.parse(gets.chomp)
  rescue
    puts "Valid inputs are 4 characters long and can include #{Code::PEGS.values.join(", ")}."
    retry
  end

  def play
    welcome_message
    play_turn until over?
    end_message
  end

  def play_turn
    @guess = get_guess
    @turns -= 1
    display_matches(guess)
  end

  def over?
    # there was a guess made AND all 4 pegs match OR no turns left
    !guess.nil? && (guess.exact_matches(secret_code) == 4 || turns.zero?)
  end

  def display_matches(code)
    puts <<~MATCHES

      Your guess is #{code.pegs.join.upcase} and you have #{turns} turns remaining!
      Your code had #{code.near_matches(secret_code)} near matches
      and #{code.exact_matches(secret_code)} exact matches.
    MATCHES
  end

  private

  def welcome_message
    print <<~WELCOME
      Welcome to Mastermind!

      We'll play with red, green, blue, yellow, orange, and purple pegs, & 10 turns max.
      Enter a sequence of four valid colors to get started.
      For example, enter 'RGBY' to denote red, green, blue, & yellow pegs. Order matters!
    WELCOME
  end

  def end_message
    puts <<~GAMEOVER

      #{"Nice! You got it." if turns > 0}
      Game over! The solution was #{secret_code.pegs.join.upcase}.
      Game took #{(turns - 10).abs} turns.
    GAMEOVER
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end

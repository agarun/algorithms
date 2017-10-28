class TowersOfHanoi
  DISCS = {
    1 => "    {:}    ",
    2 => "   {:::}   ",
    3 => "  {:::::}  "
  }

  attr_reader :towers

  def self.default
    [[3, 2, 1], [], []]
  end

  def initialize(towers = self.class.default)
    @towers = towers
    @number_of_turns = 0
  end

  def play
    until won?
      render_state

      print "Which pile do you want to select from? "
      from_tower = gets.chomp.to_i

      print "Which pile do you want to move the disc to? "
      to_tower = gets.chomp.to_i

      move(from_tower, to_tower) if valid_move?(from_tower, to_tower)
    end

    conclude
  end

  def conclude
    render_state
    puts "Congratulations! You won. Took you long enough... #{@number_of_turns - 1} turns to be exact."
  end

  # TODO heredoc
  def render_state
    DISCS.default = " " * 11
    puts <<~RENDER

       #{DISCS[towers[0][2]]} #{DISCS[towers[1][2]]} #{DISCS[towers[2][2]]}
       #{DISCS[towers[0][1]]} #{DISCS[towers[1][1]]} #{DISCS[towers[2][1]]}
       #{DISCS[towers[0][0]]} #{DISCS[towers[1][0]]} #{DISCS[towers[2][0]]}
      |=====^=====|=====^=====|=====^=====|
      |  Tower 0  |  Tower 1  |  Tower 2  |
      |===========|===========|===========|

    RENDER
  end

  def move(from_tower, to_tower)
    if valid_move?(from_tower, to_tower)
      towers[to_tower] << towers[from_tower].pop
    end
  end

  def valid_move?(from_tower, to_tower)
    if towers[from_tower].last.nil?
      false
    elsif towers[to_tower].last.nil?
      true
    elsif towers[from_tower].last < towers[to_tower].last
      true
    end
  end

  def won?
    @number_of_turns += 1
    towers[0].empty? && (towers[1].empty? || towers[2].empty?)
  end
end

# ~ notes
# `(towers[1].empty? || towers[2].empty?)`
# can be written as `@towers[1..2].any?(&:empty?)`

if $PROGRAM_NAME == __FILE__
  TowersOfHanoi.new.play
end

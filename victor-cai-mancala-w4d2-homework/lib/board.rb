require_relative 'player'

class Board
  attr_accessor :cups, :player1, :player2

  def initialize(name1, name2)
    @cups = Array.new(14) { [] }
    @player1 = Player.new(name1, 1)
    @player2 = Player.new(name2, 2)
    place_stones
  end

  def place_stones
    (0..5).each { |idx| @cups[idx] = [:stone, :stone, :stone, :stone] }
    (7..12).each { |idx| @cups[idx] = [:stone, :stone, :stone, :stone] }
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless (0..12).include?(start_pos)
    raise "Starting cup is empty" if @cups[start_pos].empty?
    
    true
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
  
    cup_index = start_pos
    until stones.empty?
      cup_index += 1
      cup_index = 0 if cup_index > 13
  
      if cup_index == 6 && current_player_name == @player1.name
        @cups[6] << stones.pop
      elsif cup_index == 13 && current_player_name == @player2.name
        @cups[13] << stones.pop
      elsif cup_index != 13
        @cups[cup_index] << stones.pop
      end
    end
  
    render
    next_turn(cup_index)
  end
  
  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12]}"
    puts "      "
    puts "#{@cups[13]} -------------------------- #{@cups[6]}"
    print "      #{@cups[0..5]}"
    puts "      "
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    case @cups[6].count <=> @cups[13].count
    when 1
      @player1.name
    when -1
      @player2.name
    else
      :draw
    end
  end
end

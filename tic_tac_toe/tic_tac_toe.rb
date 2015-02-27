class Array
  def all_empty?
    self.all? { |element| element.to_s.empty? }
  end

  def all_same?
    self.all? {|element| element == self[0]}
  end

  def not_all_same?
    !all_same?
  end

  def any_empty?
    self.any? { |element| element.to_s.empty? }
  end

  def none_empty?
    !any_empty
  end
end

class Cell
  attr_accessor :value

  def initialize(value="")
    @value = value
  end
end

class Player
  attr_reader :color, :name
  def initialize(input)
    @color = input.fetch(:color)
    @name = input.fetch(:name)
  end
end

class Board
  attr_reader :grid
  def initialize(input={})
    @grid = input.fetch(:grid, default_grid)
  end

  def get_cell(x,y)
    grid[x][y]
  end

  def set_cell(x,y,value)
    get_cell(x,y).value = value
  end

  def game_over
    return :winner if winner?
    return :draw if draw?
    false
  end


  def formatted_grid
    grid.each do |row|
      puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
    end
  end


  private

  def winning_positions
    grid + # of rows
    grid.transpose + #columns
    diagonals #two diags
  end

  def diagonals
    [
      [get_cell(0,0), get_cell(1,1), get_cell(2,2)],
      [get_cell(0,2), get_cell(1,1),get_cell(2,0)]
    ]
  end

  def winner?
    #winning positions is a nested array with all of the possible combinations of winning line ups, if any one of the nested arrays has all 'x's or 'o's then the game is over and its a win for the player that owns that color
    p "(84) winner? method"
    winning_positions.each do |winning_position|
      p "(86) winner? method non culprit looks like: #{winning_position_values(winning_position)}"
      next if winning_position_values(winning_position).not_all_same?
      #this shouldn't be an 'all empty check, we want to just confirm that no one has won and move on to the next one'
      p "(89) winner? method: pretty sure we're here in the winner"
      p "(90)culprit?: #{winning_position_values(winning_position)}"
      return true if winning_position_values(winning_position.all_same?)
    end
    false
  end

  def winning_position_values(winning_position)
    p " (97) method: winning position values being called, they are:"
    p "#{winning_position}"
    p "#{winning_position.class}"
    #so we are iterating over each element in the array, and that works, but we are running into a issue when we get to the end of the array
    winning_position.map { |cell| cell.value }
  end

  def draw?
    grid.flatten.map { |cell| cell.value }.none_empty?
  end #uses an array method i made, might need to include it or something

  def default_grid
    Array.new(3) { Array.new(3) { Cell.new } }
  end

end

class Game

  attr_reader :players, :board, :current_player, :other_player

  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def solicit_move
    "#{current_player.name}: Enter a number between 1 and 9 to make your move"
  end

  def get_move(human_move = gets.chomp)
    human_move_to_coordinate(human_move)
  end

  def game_over_message
    p "method: game over message (137)"
    return "#{current_player.name} won!" if board.game_over == :winner
    return "The game ended in a tie" if board.game_over == :draw
  end

  def play
    puts "#{current_player.name} has randomly been selected as the first player"
    while true
      p "play method (145)"
      board.formatted_grid
      puts ""
      puts solicit_move
      x, y = get_move
      p "#{x} and #{y} "
      board.set_cell(x, y, current_player.color)
      p "play method (152)"
      if board.game_over

        puts game_over_message
        board.formatted_grid
        return
      else
        switch_players
      end
    end
  end

  private

  def human_move_to_coordinate(human_move)
    mapping = {
      "1" => [0, 0],
      "2" => [0, 1],
      "3" => [0, 2],
      "4" => [1, 0],
      "5" => [1, 1],
      "6" => [1, 2],
      "7" => [2, 0],
      "8" => [2, 1],
      "9" => [2, 2]
    }
    mapping[human_move]
  end

end


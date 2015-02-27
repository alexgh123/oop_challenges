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
    if board.grid.each do |small_array|
      small_array.each do |cell|
        if cell.value.empty?
          false
        else
          true
        end
      end
    end
      p "idk"


    end
  end




    if board.include("X")
      p "x on the board, over!"
      return true
    elsif board.include("O")
      p "o on theboard, over!"
      return true
    else
      false
    end


  end

    # if winner?
    #   p "winner? returned true"
    #   return :winner
    # elsif draw?
    #   p "draw returned true"
    #   return :draw
    # else
    #   p "neither returned true"
    #   false
    # end
  # end


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

    winning_positions.each do |winning_position|
      next if winning_position_values(winning_position).not_all_same?
      return true if winning_position_values(winning_position.all_same?)
    end
    false
  end

  def winning_position_values(winning_position)
    p "winning position:"
    p "#{winning_position}"
    winning_position.map { |cell| cell.value }
  end

  def draw?
    grid.flatten.map { |cell| cell.value }.none_empty?
  end

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

    return "#{current_player.name} won!" if board.game_over == :winner
    return "The game ended in a tie" if board.game_over == :draw
  end

  def play
    puts "#{current_player.name} has randomly been selected as the first player"
    while true

      board.formatted_grid
      puts ""
      puts solicit_move
      x, y = get_move

      board.set_cell(x, y, current_player.color)
      # p""
      # p "board object: #{board}"
      # p ""
      # p "printing board.grid[0][1]"
      # p board.grid[0][1]

      #game_over conditions
        # 3 in a row
        # board is full
          #if at each board.grid value, it contains an x or a y, game is over


      if game_over
        p "I don't want to see you"
      else
        switch_players
      end

      # if board.game_over
      #   p "game over path"

      #   puts game_over_message
      #   board.formatted_grid
      #   return
      # else
      #   p "swithced players path"
      #   switch_players
      # end

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

test = Board.new
# p test
# p test.game_over
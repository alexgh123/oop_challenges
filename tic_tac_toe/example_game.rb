require_relative "tic_tac_toe.rb"

puts "Welcome to tic tac toe"
bob = Player.new({color: "X", name: "bob"})
frank = Player.new({color: "O", name: "frank"})
players = [bob, frank]
# Game.new(players).play
test = Game.new(players)
p test.board.grid.class #should be a nested array


#so for each
p ""
p test.board.grid[0][0].value = "x"
p test.board.grid[0][1]
p test.board.grid[0][2]

p test.board.grid[1][0]
p test.board.grid[1][1]
p test.board.grid[1][2]

p test.board.grid[2][0]
p test.board.grid[2][1]
p test.board.grid[2][2]

p "-------------"


test.board.grid.each do |small_array|
  small_array.each do |cell|
    if cell.value.empty?
      p "continue game"
    else
      p "game over"
    end
  end
end

p test.board.winning_positions
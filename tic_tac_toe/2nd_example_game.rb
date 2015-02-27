require_relative "tic_tac_toe.rb"

puts "Welcome to tic tac toe"
bob = Player.new({color: "X", name: "bob"})
frank = Player.new({color: "O", name: "frank"})
players = [bob, frank]
Game.new(players).play
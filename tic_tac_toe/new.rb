
@board = ["","","","","","","","",""]
@board_key = [1,2,3,4,5,6,7,8,9]

def display_board
  p "board key is:"
  p @board_key[0..2]
  p @board_key[3..5]
  p @board_key[6..8]
  p "board is: "
  p @board[0..2]
  p @board[3..5]
  p @board[6..8]
end

def user_input_converter(input)
  input -1
end

def welcome_and_names
  p "Welcome! to Tic Tac Toe!"
  p "Player 1 enter your name!"
  @player_one_name = gets.chomp
  p "Player 2 enter your name!"
  @player_two_name = gets.chomp
  p "here is your board!"
end

def name_and_symbol_assignment(count)
  if count % 2 == 0
    @player = @player_one_name
    @symbol = "X"
  else
    @player = @player_two_name
    @symbol = "O"
  end
end

#begin win determination logic

def array_of_winning_lines

end

def tic_tac_toe_condition_arrays
#for each array_of_winning_lines, if it is not empty, and the length is

  @board[0..2].uniq.length == 1
  # @board[3..5].uniq.length == 1
  # @board[6..8].uniq.length == 1
  # [@board[0],@board[3],@board[6]].uniq.length == 1

  #so that might be kinda the way, but after three moves, i have to check if it actually was a win

  #if not empty, are they the same
end

def winner_check
  #if board has any of the pre approved winning combinations, then there is a win
  if tic_tac_toe_condition_arrays
    p "#{@player} wins!"
    true
  else
    false
  end
end

#end win determination logic, this is a bitch!

def taking_turns
  count = 0
  loop do
    name_and_symbol_assignment(count)
    p "#{@player} what is your move ?"
    player_input = user_input_converter(gets.chomp.to_i)
    @board[player_input] = @symbol
    display_board
    winner_check
    count += 1
    break if winner_check
    break if count > 8
  end
end

def play
  welcome_and_names
  display_board
  taking_turns
end

play


@board = ["","","","","","","","",""]
@board_key = [1,2,3,
  4,5,6,
  7,8,9]

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
  raise ArgumentError, "please use the digits 1-9" unless @board_key.include?(input)
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

def nested_array_of_winning_lines
  [
    [ @board[0],@board[4],@board[8] ], #diag
    [ @board[2],@board[4],@board[6] ], #diag
      @board[0..2], #horozontals
      @board[3..5], #horozontals
      @board[6..8], #horozontals
    [ @board[0], @board[3], @board[6] ], #vert
    [ @board[1], @board[4], @board[7] ], #vert
    [ @board[2], @board[5], @board[8] ] #vert
  ]
end

def tic_tac_toe_condition_arrays
  nested_array_of_winning_lines.each do |line|
      if line.include?("X")
        if line.uniq.length == 1
          return true
        end
      elsif line.include?("O")
        if line.uniq.length == 1
          return true
        end
      end
  end #ends do
  false
end #ends method

def winner_check
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
    p "player input is #{player_input}"
    @board[player_input] = @symbol
    display_board
    winner_check
    count += 1
    break if winner_check
    p "aw, its a tie" if count > 8
    break if count > 8
  end
end

def play
  welcome_and_names
  display_board
  taking_turns
end


play
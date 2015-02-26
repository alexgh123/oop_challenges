require_relative 'tic_tac_toe'

describe Cell do

  context "#initialize" do
    it "is initialized with a value of '' by default" do
      cell = Cell.new
      expect(cell.value).to eq ''
    end
  end

  it "can be initalized with a value of 'X' " do
    cell = Cell.new("X")
    expect(cell.value).to eq "X"
  end

end

describe Player do

  context "#initialize" do
    it "raises an exception when initialized with {}" do
      expect { Player.new({}) }.to raise_error
    end

    it "does not raise an error when initialized with a valid input" do
      input = {color: "X", name: "someone"}
      expect { Player.new(input) }.to_not raise_error
    end
  end #ends initialize context

  context "#color" do
    it "returns the color" do
      input = { color: "magenta" , name: "Someone" }
      player = Player.new(input)
      expect(player.color).to eq "magenta"
    end
  end #end color context

  context "#name" do
    it "returns the player's name" do
      input = { color: "X", name: "Spicoli" }
      playa = Player.new(input)
      expect(playa.name).to eq "Spicoli"
    end
  end #end name context

end

describe Board do

  context "#initialize" do
    it "initializes the board with a grid" do
      expect { Board.new(grid: "grid") }.to_not raise_error
    end

    it "sets the grid with three rows by default" do
      board = Board.new
      expect(board.grid.size).to eq(3)
    end

    it "creates three things in each row by default" do
      board = Board.new
      board.grid.each do |row|
        expect(row.size).to eq(3)
      end
    end

  end

  context "#grid" do

    it "returns the grid" do
      board = Board.new(grid: "blah")
      expect(board.grid).to eq "blah"
    end

    it "returns the correct cell" do
      grid = [[1,"giraff",3],[4,5,6],[7,8,9]]
      board = Board.new(grid: grid)
      expect(board.get_cell(0,1)).to eq("giraff")
      expect(board.get_cell(1,1)).to eq(5)
    end

  end

  context "#set_cell" do
    it "updates the value of the cell object at (x,y) coordinate" do
      Cat = Struct.new(:value) #never seen this before
      grid = [[Cat.new("cool"), "",""],["","",""],["","",""]]
      board = Board.new(grid: grid)
      board.set_cell(0,0, "meow")
      expect(board.get_cell(0,0).value).to eq "meow"
    end
  end

  TestCell = Struct.new(:value)
  let(:x_cell) { TestCell.new("X") }
  let(:y_cell) { TestCell.new("Y") }
  let(:empty) { TestCell.new }

  context "#game_over" do
    it "returns :winner if winner? is true" do
      board = Board.new
      board.stub(:winner?) {true}
      expect(board.game_over).to eq :winner
    end

    it "returns :draw if winner? is false and draw? is true" do
      board = Board.new
      board.stub(:winner?) { false }
      board.stub(:draw?) { true }
      expect(board.game_over).to eq :draw
    end

    it "returns false if #winner? is false and #draw? is false" do
      board = Board.new
      board.stub(:winner?) { false }
      board.stub(:draw?) { false }
      expect(board.game_over).to be_false
    end

    it "returns :winner when row has objects with values that are all the same" do
      grid = [
      [x_cell, x_cell, x_cell],
      [y_cell, x_cell, y_cell],
      [y_cell, y_cell, empty]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :winner
    end

    it "returns :winner when colum has objects with values that are all the same" do
    grid = [
      [x_cell, x_cell, empty],
      [y_cell, x_cell, y_cell],
      [y_cell, x_cell, empty]
    ]
    board = Board.new(grid: grid)
    expect(board.game_over).to eq :winner
    end

    it "returns :winner when diagonal has objects with values that are all the same" do
    grid = [
      [x_cell, empty, empty],
      [y_cell, x_cell, y_cell],
      [y_cell, x_cell, x_cell]
    ]
    board = Board.new(grid: grid)
    expect(board.game_over).to eq :winner
  end

  it "returns :draw when all spaces on the board are taken" do
    grid = [
      [x_cell, y_cell, x_cell],
      [y_cell, x_cell, y_cell],
      [y_cell, x_cell, y_cell]
    ]
    board = Board.new(grid: grid)
    expect(board.game_over).to eq :draw
  end

  it "returns false when there is no winner or draw" do
    grid = [
      [x_cell, empty, empty],
      [y_cell, empty, empty],
      [y_cell, empty, empty]
    ]
    board = Board.new(grid: grid)
    expect(board.game_over).to be_false
  end

  end

end

describe Array do

  context "#all_empty?" do

    it "returns true if all elements of the Array are empty" do
      expect(["","",""].all_empty?).to be_true
    end

    it "returns false if some of the Array elements are not empty" do
      expect(["",1,"", Object.new, :a].all_empty?).to be_false
    end

    it "returns true for an empty Array" do
      expect([].all_empty?).to be_true
    end

  end

  context "#all_same?" do

    it "returns true if all elements of the Array are the same" do
      expect(["A", "A", "A"].all_same?).to be_true
    end

    it "returns false if some of the Array elements are not the same" do
      expect(["", 1, "", Object.new, :a].all_same?).to be_false
    end

    it "returns true for an empty Array" do
      expect([].all_same?).to be_true
    end
  end

  context "#any_empty?" do
    #i would rather test behavior than methods
  end

end

describe Game do

    let (:bob) { Player.new({color: "X", name: "bob"}) }
    let (:frank) { Player.new({color: "O", name: "frank"}) }

    context "#initialize" do
      it "randomly selects a current_player" do
        Array.any_instance.stub(:shuffle) { [frank, bob] }
        game = Game.new([bob, frank])
        expect(game.current_player).to eq frank
      end

      it "randomly selects an other player" do
        Array.any_instance.stub(:shuffle) { [frank, bob] }
        game = Game.new([bob, frank])
        expect(game.other_player).to eq bob
      end
    end

    context "#switch_players" do

      it "will set @current_player to @other_player" do
        game = Game.new([bob, frank])
        other_player = game.other_player
        game.switch_players
        expect(game.current_player).to eq other_player
      end

      it "will set @other_player to @current_player" do
        game = Game.new([bob, frank])
        current_player = game.current_player
        game.switch_players
        expect(game.other_player).to eq current_player
      end
    end

    context "#solicit_move" do

      it "asks the player to make a move" do
        game = Game.new([bob, frank])
        game.stub(:current_player) { bob }
        expected = "bob: Enter a number between 1 and 9 to make your move"
        expect(game.solicit_move).to eq expected
      end

    end

    context "#get_move" do
      it "converts human_move of '1' to [0, 0]" do
        game = Game.new([bob, frank])
        expect(game.get_move("1")).to eq [0, 0]
      end

      it "converts human_move of '1' to [0, 0]" do
        game = Game.new([bob, frank])
        expect(game.get_move("7")).to eq [0, 2]
      end
    end

    context "#game_over_message" do

      it "returns '{current player name} won!' if board shows a winner" do
        game = Game.new([bob, frank])
        game.stub(:current_player) { bob }
        game.board.stub(:game_over) { :winner }
        expect(game.game_over_message).to eq "bob won!"
      end

      it "returns 'The game ended in a tie' if board shows a draw" do
        game = Game.new([bob, frank])
        game.stub(:current_player) { bob }
        game.board.stub(:game_over) { :draw }
        expect(game.game_over_message).to eq "The game ended in a tie"
      end
    end

end
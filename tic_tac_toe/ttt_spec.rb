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
      board = Board.new(grid: [[1,2,3],[4,5,6],[7,8,9]])
      expect(board.get_cell(0,1)).to eq(1)
    end
  end

#right now they want the grid cell method to pass args in as 'x' THEN 'y' ,but then look them up  in reverse order. why, the 'x' is the horozontal, i bleive, y is vertical, which makes sense within the concept of geometry and algebra, but presumably we know that we are using a nested array, right? and we want to pass the args in in the order of the nested array we are trying to access





end
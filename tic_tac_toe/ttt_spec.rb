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






end
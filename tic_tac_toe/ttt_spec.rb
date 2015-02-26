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
  end



end
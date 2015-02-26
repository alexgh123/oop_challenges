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
    @grid[x][y]
  end

  def set_cell(x,y,value)
    get_cell(x,y).value = value
  end

  private

  def default_grid
    Array.new(3) { Array.new(3) { Cell.new } }
  end

end


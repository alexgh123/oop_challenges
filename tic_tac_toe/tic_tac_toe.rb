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
  def initialize(input)
    @board = input.fetch(:grid)

  #   [
  #    ["","",""],
  #    ["","",""],
  #    ["","",""]
  #  ]

  end
end


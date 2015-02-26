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

def Board
  def initialize(input)
    @board = input.fetch(:grid)

  #   [
  #    ["","",""],
  #    ["","",""],
  #    ["","",""]
  #  ]

  end
end

#pretty sure fetch obviosuly helps you catch errors if you try and call an arg that isn't present, but i think it has a roll in data sanitation too
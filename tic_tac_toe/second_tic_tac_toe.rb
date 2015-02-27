array = ["","",""]

class Array
  def all_empty?
    self.uniq.size <= 1
    # "potatoes"
  end
end

p array.all_empty?

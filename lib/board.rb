class Board
  def initialize(values)
    @values = values
  end

  def play(word)
    word.each_char.inject(0) { |score, c| score + @values[c] }
  end
end

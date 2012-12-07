require "direction"

class Position
  attr_reader :col, :row

  def initialize(col, row)
    @col = col
    @row = row
  end

  def shift(offset, direction)
    if direction == Direction::HORIZONTAL
      Position.new(col + offset, row)
    else
      Position.new(col, row + offset)
    end
  end

  def previous(direction)
    shift(-1, direction)
  end

  def next(direction)
    shift(1, direction)
  end

  def ==(other)
    [col, row] == [other.col, other.row]
  end

  def eql?(other)
    [col, row].eql?([other.col, other.row])
  end

  def hash
    [col, row].hash
  end
end

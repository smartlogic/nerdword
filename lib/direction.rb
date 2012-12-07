module Direction
  HORIZONTAL = "Horizontal".freeze
  VERTICAL = "Vertical".freeze

  def self.opposite(direction)
    if direction == HORIZONTAL
      VERTICAL
    else
      HORIZONTAL
    end
  end
end

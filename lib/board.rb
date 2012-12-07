class Board
  def initialize(values)
    @values = values
    @history = []
  end

  def play(move)
    index = generate_index(@history)
    words = find_words(move, index)
    @history << move
    words.inject(0) { |score, word| score + score_word(word) }
  end

  private

  def find_words(move, index)
    words = [move.word]

    direction = move.direction
    orthogonal_direction = Direction.opposite(direction)

    move.word.length.times do |i|
      current = move.position.shift(i, direction)
      next if index[current] # not placed by us, so don't look for adjacent letters

      behind = current.previous(orthogonal_direction)
      ahead = current.next(orthogonal_direction)

      if index[behind] || index[ahead]
        total_index = generate_index(@history + [move])
        word_start = find_word_start(current, orthogonal_direction, total_index)
        words << find_word(word_start, orthogonal_direction, total_index)
      end
    end

    words
  end

  def find_word_start(position, direction, index)
    prev = position.previous(direction)

    if index[prev]
      find_word_start(prev, direction, index)
    else
      position
    end
  end

  def find_word(start, direction, index, prefix = index[start])
    ahead = start.next(direction)

    if index[ahead]
      find_word(ahead, direction, index, prefix + index[ahead])
    else
      prefix
    end
  end

  def generate_index(history)
    index = {}

    history.each do |move|
      move.word.each_char.with_index do |char, i|
        index[move.position.shift(i, move.direction)] = move.word[i]
      end
    end

    index
  end

  def score_word(word)
    word.each_char.inject(0) { |score, c| score + @values[c] }
  end
end

require "board"
require "move"
require "position"

describe Board do
  it "scores a move" do
    values = { ?C => 2, ?A => 4, ?T => 8 }
    board = Board.new(values)

    score = board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})

    score.should eq(14)
  end

  it "scores a multi-word move" do
    values = { ?C => 4, ?A => 1, ?T => 1, ?I => 1, ?N => 2 }
    board = Board.new(values)

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})
    score = board.play(Move.new("TIN", Position.new(1, 1), Direction::HORIZONTAL), %w{T I N})

    score.should eq(8)
  end

  it "uses up tiles from the rack" do
    values = Hash.new(1)
    board = Board.new(values)
    rack = %w{C A T S}

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), rack)
    rack.should eq(%w{S})

    board.play(Move.new("CATS", Position.new(0, 0), Direction::HORIZONTAL), rack)
    rack.should be_empty
  end

  it "scores letter multipliers" do
    values = { ?C => 2, ?A => 4, ?T => 8 }
    letter_multipliers = { Position.new(0, 0) => 2 }
    board = Board.new(values, letter_multipliers)

    score = board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})

    score.should eq(16)
  end

  it "scores letter multipliers in every word formed" do
    values = Hash.new(1)
    letter_multipliers = { Position.new(1, 1) => 2 }
    board = Board.new(values, letter_multipliers)

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})
    score = board.play(Move.new("TIN", Position.new(1, 1), Direction::HORIZONTAL), %w{T I N})

    score.should eq(9)
  end

  it "only counts letter multipliers played this turn" do
    values = { ?C => 2, ?A => 4, ?T => 8, ?S => 1 }
    letter_multipliers = { Position.new(0, 0) => 2 }
    board = Board.new(values, letter_multipliers)

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})
    score = board.play(Move.new("CATS", Position.new(0, 0), Direction::HORIZONTAL), %w{S})

    score.should eq(15)
  end

  it "scores word multipliers" do
    values = { ?C => 2, ?A => 4, ?T => 8 }
    word_multipliers = { Position.new(0, 0) => 2 }
    board = Board.new(values, {}, word_multipliers)

    score = board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})

    score.should eq(28)
  end

  it "scores word multipliers in every word formed" do
    values = Hash.new(1)
    word_multipliers = { Position.new(1, 1) => 2 }
    board = Board.new(values, {}, word_multipliers)

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})
    score  = board.play(Move.new("TIN", Position.new(1, 1), Direction::HORIZONTAL), %w{T I N})

    score.should eq(12)
  end

  it "doesn't count word multipliers twice" do
    values = { ?C => 2, ?A => 4, ?T => 8, ?S => 1 }
    word_multipliers = { Position.new(0, 0) => 2 }
    board = Board.new(values, {}, word_multipliers)

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL), %w{C A T})
    score = board.play(Move.new("CATS", Position.new(0, 0), Direction::HORIZONTAL), %w{S})

    score.should eq(15)
  end

  it "scores a 50 point bingo bonus" do
    values = Hash.new(1)
    board = Board.new(values)

    score = board.play(Move.new("RAMRODS", Position.new(0, 0), Direction::HORIZONTAL), %w{R A M R O D S})

    score.should eq(57)
  end

  it "only gives bingo bonus if 7 tiles are used" do
    values = Hash.new(1)
    board = Board.new(values)

    board.play(Move.new("RAM", Position.new(0, 0), Direction::HORIZONTAL), %w{R A M})
    score = board.play(Move.new("RAMRODS", Position.new(0, 0), Direction::HORIZONTAL), %w{R O D S})

    score.should eq(7)
  end
end

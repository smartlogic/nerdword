require "board"
require "move"
require "position"

describe Board do
  it "scores a move" do
    values = { ?C => 2, ?A => 4, ?T => 8 }
    board = Board.new(values)

    score, _ = board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))

    score.should eq(14)
  end

  it "scores a multi-word move" do
    values = { ?C => 4, ?A => 1, ?T => 1, ?I => 1, ?N => 2 }
    board = Board.new(values)

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))
    score, _ = board.play(Move.new("TIN", Position.new(1, 1), Direction::HORIZONTAL))

    score.should eq(8)
  end

  it "returns the tiles used to make the play" do
    values = { ?C => 1, ?A => 4, ?T => 8, ?S => 1 }
    board = Board.new(values)

    _, tiles_used1 = board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))
    _, tiles_used2 = board.play(Move.new("CATS", Position.new(0, 0), Direction::HORIZONTAL))

    tiles_used1.should eq(%w{C A T})
    tiles_used2.should eq(%w{S})
  end
end

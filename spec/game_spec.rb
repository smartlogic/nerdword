require "player"
require "board"
require "move"
require "position"

describe "Game" do
  it "plays a round" do
    values = {
      "P" => 4,
      "O" => 1,
      "I" => 1,
      "S" => 1
    }

    board = Board.new(values)
    p1 = Player.new(board, nil)
    p2 = Player.new(board, nil)

    p1.play(Move.new("POO", Position.new(0, 0), Direction::HORIZONTAL))
    p2.play(Move.new("PISS", Position.new(0, 0), Direction::VERTICAL))

    p1.score.should == 6
    p2.score.should == 7
  end
end

require "player"
require "board"

describe "Game" do
  it "plays a round" do
    values = {
      "P" => 4,
      "O" => 1,
      "I" => 1,
      "S" => 1
    }

    board = Board.new(values)
    p1 = Player.new(board)
    p2 = Player.new(board)

    p1.play("POO")
    p2.play("PISS")

    p1.score.should == 6
    p2.score.should == 7
  end
end

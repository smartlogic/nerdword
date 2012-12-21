require "player"
require "move"
require "position"

describe Player do
  let(:board) { mock }
  let(:pouch) { mock }

  it "draws tiles from the pouch" do
    rack = []
    player = Player.new(board, pouch, rack)

    pouch.stub(:draw).with(7).and_return(%w{A B C})
    player.draw

    rack.should eq(%w{A B C})
  end

  it "only draws the tiles needed" do
    rack = %w{A B C}
    player = Player.new(board, pouch, rack)

    pouch.stub(:draw).with(4).and_return(%w{D E F})
    player.draw

    rack.should eq(%w{A B C D E F})
  end

  it "exchanges tiles with new ones from the pouch" do
    rack = %w{A B C D E F G}
    player = Player.new(board, pouch, rack)

    pouch.stub(:exchange).with(%w{A B C}).and_return(%w{X Y Z})
    player.exchange(%w{A B C})

    rack.should eq(%w{D E F G X Y Z})
  end

  it "plays a move on the board using her rack" do
    rack = %w{C A T}
    player = Player.new(board, pouch, rack)
    move = Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL)

    board.should_receive(:play).with(move, rack).and_return(0)

    player.play(move)
  end

  it "records her score" do
    player = Player.new(board, pouch)
    move = Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL)
    board.stub(:play).and_return(1)

    player.play(move)

    player.score.should eq(1)
  end
  
  it "add the scores of multiple plays" do
    player = Player.new(board, pouch)
    board.stub(:play).and_return(1)

    player.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))
    player.play(Move.new("COT", Position.new(0, 0), Direction::VERTICAL))

    player.score.should eq(2)
  end
end

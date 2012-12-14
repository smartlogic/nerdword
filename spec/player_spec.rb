require "player"
require "move"
require "position"

describe Player do
  let(:board) { mock }
  let(:pouch) { mock }

  it "draws tiles from the pouch" do
    player = Player.new(board, pouch)

    pouch.stub(:draw).with(7).and_return(%w{A B C})

    expect { player.draw }.to change(player, :tiles).to(%w{A B C})
  end

  it "only draws the tiles needed" do
    player = Player.new(board, pouch, %w{A B C})

    pouch.stub(:draw).with(4).and_return(%w{D E F})

    expect { player.draw }.to change(player, :tiles).to(%w{A B C D E F})
  end

  it "exchanges tiles with new ones from the pouch" do
    player = Player.new(board, pouch, %w{A B C D E F G})

    pouch.stub(:exchange).with(%w{A B C}).and_return(%w{X Y Z})
    player.exchange(%w{A B C})

    player.tiles.should eq(%w{D E F G X Y Z})
  end

  it "uses up tiles to make a move" do
    player = Player.new(board, pouch, %w{A B C D E})

    board.stub(:play).and_return([1, %w{A C E}])
    player.play(Move.new("", Position.new(0, 0), Direction::HORIZONTAL))

    player.tiles.should eq(%w{B D})
  end

  it "records her score" do
    player = Player.new(board, pouch)
    move = Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL)
    board.stub(:play).with(move).and_return([1, []])

    player.play(move)

    player.score.should eq(1)
  end
  
  it "add the scores of multiple plays" do
    player = Player.new(board, pouch)
    board.stub(:play).and_return([1, []])

    player.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))
    player.play(Move.new("COT", Position.new(0, 0), Direction::VERTICAL))

    player.score.should eq(2)
  end
end

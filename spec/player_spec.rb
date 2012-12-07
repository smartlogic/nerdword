require "player"
require "move"
require "position"

describe Player do
  let(:board) { mock }
  let(:pouch) { mock }
  let(:player) { Player.new(board, pouch) }

  it "draws tiles from the pouch" do
    pouch.stub(:draw).with(7).and_return(%w{A B C})

    expect { player.draw }.to change(player, :tiles).to(%w{A B C})
  end

  it "only draws the tiles needed" do
    pouch.stub(:draw).with(4).and_return(%w{D E F})

    player.tiles.concat(%w{A B C})

    expect { player.draw }.to change(player, :tiles).to(%w{A B C D E F})
  end

  it "records her score" do
    move = Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL)
    board.stub(:play).with(move).and_return(1)

    player.play(move)

    player.score.should eq(1)
  end
  
  it "add the scores of multiple plays" do
    board.stub(:play).and_return(1)
    
    player.play(stub)
    player.play(stub)

    player.score.should eq(2)
  end
end

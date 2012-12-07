require "pouch"

describe Pouch do
  it "allows players to draw tiles" do
    pouch = Pouch.new(%w{A B C D E F G}, Random.new(1))

    draw1 = pouch.draw(4)
    draw2 = pouch.draw(4)

    draw1.should eq(%w{D G F B})
    draw2.should eq(%w{C A E})
  end
end

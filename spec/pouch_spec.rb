require "pouch"
require "not_random"

describe Pouch do
  it "allows players to draw tiles" do
    pouch = Pouch.new(%w{A B C D E F G}, NotRandom.new)

    draw1 = pouch.draw(4)
    draw2 = pouch.draw(4)

    draw1.should eq(%w{A B C D})
    draw2.should eq(%w{E F G})
  end
end

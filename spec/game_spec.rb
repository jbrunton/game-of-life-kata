class Game
  def initialize(counters)
  end
  
  def active_counters
    []
  end
end

describe "Game" do
  context "when the board is empty" do
    it "has no active counters" do
      game = Game.new([])
      expect(game.active_counters).to be_empty
    end
  end
end

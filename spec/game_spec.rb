require_relative File.expand_path('spec/spec_helper')

describe "Game" do
  context "#initialize" do
    it "sets the initially active cells" do
      game = Game.new([ {x: 1, y: 1} ])
      expect(game.active_cells).to eq([ {x: 1, y: 1} ])
    end
  end
  
  context "#play" do
    it "applies a single round of the rules" do
      game = Game.new([ x:1, y: 1])
      game.play
      expect(game.active_cells).to be_empty
    end
  end
end

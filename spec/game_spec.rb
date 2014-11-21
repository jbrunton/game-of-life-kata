require_relative File.expand_path('spec/spec_helper')

describe "Game" do
  context "#initialize" do
    it "sets the initially active cells" do
      game = Game.new([ {x: 1, y: 2} ])
      expect(game.active_cells).to eq([ {x: 1, y: 2} ])
    end
  end
end

describe "Game" do
  class Game
    attr_reader :live_cells
    def initialize(initial_cells)
      @live_cells = initial_cells
    end
  end
  
  context "#initialize" do
    it "initializes the instance" do
      initial_cells = [{ :x => 1, :y => 1 }]
      game = Game.new initial_cells
      expect(game.live_cells).to eq(initial_cells)
    end
  end

  context "if there are no live cells" do
    it "does nothing" do
      
    end
  end
end

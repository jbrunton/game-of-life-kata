class Game
  def initialize(initial_cells)
    @active_cells = initial_cells
  end
  
  def active_cells
    @active_cells
  end
end

describe "Game" do
  context "when the board is empty" do
    it "has no active cells" do
      game = Game.new([])
      expect(game.active_cells).to be_empty
    end
  end
  
  context "when the board is initialized" do
    it "lists the active cells" do
      game = Game.new([ {x: 1, y: 2} ])
      expect(game.active_cells).to eq([ {x: 1, y: 2} ])
    end
  end
end

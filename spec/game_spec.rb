require File.dirname(__FILE__) + '/spec_helper'

class Game
  def initialize(initial_cells)
    @active_cells = initial_cells
  end
  
  def active_cells
    @active_cells
  end
  
  def play
    @active_cells = []
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
  
  context "underpopulation rule" do
    context "if the cell has no neighbors" do
      before(:each) do
        initialize_board \
          [0,0,0],
          [0,1,0],
          [0,0,0]
        play
      end
      
      it "should die after one play" do
        expect_board \
          [0,0,0],
          [0,0,0],
          [0,0,0]
      end
    end
    
    context "if the cell has 1 neighbor" do
      before(:each) do
        initialize_board \
          [0,0,0],
          [0,1,1],
          [0,0,0]
        play
      end

      it "should die after one play" do
        expect_board \
          [0,0,0],
          [0,0,0],
          [0,0,0]
      end
    end
  end  
end

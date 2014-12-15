require File.expand_path 'spec/fixtures'

describe "Rules" do
  include Fixtures
  
  describe "Underpopulation" do
    it "kills single cells" do
      initialize_board \
        [0,0,0],
        [0,1,0],
        [0,0,0]
      tick
      expect_board \
        [0,0,0],
        [0,0,0],
        [0,0,0]
    end
  end
  
  describe "Survival" do
    it "keeps cells with 2 or 3 neighbors alive" do
      initialize_board \
        [0,0,0],
        [1,1,1],
        [0,1,0]
      tick
      expect_board \
        [0,0,0],
        [1,1,1],
        [0,1,0]
    end
  end
  
  describe "Overcrowding" do
    it "kills cells with more than 3 live neighbors" do
      initialize_board \
        [0,1,0],
        [1,1,1],
        [0,1,0]
      tick
      expect_board \
        [0,1,0],
        [1,0,1],
        [0,1,0]
    end
  end
end

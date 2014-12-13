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
end

require_relative File.expand_path('spec/spec_helper')

describe "Rules" do
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
  
  context "survival rule" do
    context "if the cell has 2 neighbors" do
      before(:each) do
        initialize_board \
          [0,1,0],
          [0,1,0],
          [0,1,0]
        play
      end
      
      it "should survive" do
        expect_board \
          [0,0,0],
          [0,1,0],
          [0,0,0]
      end
    end
  end
end

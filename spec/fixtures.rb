module Fixtures
  def initialize_board(*rows)
    @game = Game.new list_live_cells(rows)
  end
  
  def tick
    @game.tick
  end
  
  def expect_board(*rows)
    actual_live_cells = sort_cells(@game.live_cells)
    expected_live_cells = sort_cells(list_live_cells(rows))
    expect(actual_live_cells).to eq(expected_live_cells)
  end
  
  def list_live_cells(rows)
    live_cells = []
    rows.each_index do |row_index|
      row = rows[row_index]
      row.each_index do |column_index|
        unless rows[row_index][column_index].zero?
          live_cells.push({ :x => column_index, :y => rows.size - 1 - row_index })
        end
      end
    end
    live_cells
  end
  
  def sort_cells(cells)
    cells.sort do |a, b|
      result = a[:x] <=> b[:x]
      result = b[:y] <=> b[:y] if result.zero?
      result
    end
  end
end

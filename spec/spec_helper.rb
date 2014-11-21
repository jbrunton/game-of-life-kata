require_relative File.expand_path('game')

module HelperMethods
  def initialize_board(*rows)
    initial_cells = convert_to_cells(rows)
    @game = Game.new(initial_cells)
  end
  
  def play
    @game.play
  end
  
  def expect_board(*rows)
    expected_cells = convert_to_cells(rows)
    actual_cells = @game.active_cells.sort do |a,b|
      result = a[:y] <=> b[:y]
      result = a[:x] <=> b[:x] if result.zero?
      result
    end
    expect(actual_cells).to eq(expected_cells)
  end
  
private
  def convert_to_cells(rows)
    cells = []
    rows.each_index do |y|
      rows[y].each_index do |x|
        cells.push({x: x, y: (rows.length - 1) - y}) unless rows[y][x].zero?
      end
    end
    cells
  end
end

RSpec.configure do |c|
  c.include HelperMethods
end

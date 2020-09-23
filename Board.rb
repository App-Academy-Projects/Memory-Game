class Board
    attr_accessor :grid, :size
    def initialize(size)
        @size = size
        @grid = Array.new(size) { [] }
    end

    def populate
        
    end

    def render
        
    end

    def won?
        
    end

    def reveal
        
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
        @grid[pos] = value
    end
end
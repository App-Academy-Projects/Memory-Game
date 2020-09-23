require_relative 'Board'

class Game
    def initialize(size)
        @board = Board.new(size)
        @previous_guess = nil

        @board.populate
    end

    def play
        while !over?
            # ...
        end
        puts "You Won!!!"
    end

    def over?
        @board.won?
    end

    def valid_pos?(pos)
        # ...
    end

    def make_guess

    end
end
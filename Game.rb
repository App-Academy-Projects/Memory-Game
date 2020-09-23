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
        size = @board.size
        return false if not pos.all? { |el| el < size && el >= 0 }
        card = @board[pos]
        return !card.revealed?
    end

    def make_pos(pos)
        pos = pos[0].to_i, pos[1].to_i
        pos
    end

    def make_guess
        puts
        print "Enter a position of card you want to flip ex.`1 2`: "
        guessed_pos = gets.chomp.split
        raise "Invalid position, should be like `row col`" if guessed_pos.length < 2
        guessed_pos = make_pos(guessed_pos)
        raise "Invalid position" if !valid_pos?(guessed_pos)
        guessed_pos
    end
end
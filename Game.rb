require_relative 'Board'

class Game
    def initialize(size)
        @board = Board.new(size)
        @previous_guess = nil

        @board.populate
    end

    def play
        while !over?
            clear_and_render
            guessed_pos = make_guess
            @board.reveal(guessed_pos)
            if @previous_guess == nil
                @previous_guess = guessed_pos
                next
            elsif @board[guessed_pos] != @board[@previous_guess] 
                clear_and_render
                sleep(2)
                hide_cards(guessed_pos, @previous_guess)
            end
            @previous_guess = nil
        end
        puts "You Won!!!"
    end

    def hide_cards(pos1, pos2)
        @board[guessed_pos].hide
        @board[@previous_guess].hide
    end

    def clear_and_render
        system("clear")
        @board.render
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
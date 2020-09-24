require_relative 'Board'
require_relative 'HumanPlayer'

class Game
    def initialize(size=4)
        raise "Invalid size, should be even!" if size % 2 != 0
        @board = Board.new(size)
        @previous_guess = nil

        @board.populate
    end
    
    def play
        h = HumanPlayer.new(@board)
        while !over?
            clear_and_render
            guessed_pos = h.make_guess
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
        @board[pos1].hide
        @board[pos2].hide
    end

    def clear_and_render
        system("clear")
        @board.render
    end

    def over?
        @board.won?
    end
end
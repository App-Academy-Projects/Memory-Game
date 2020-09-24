require_relative 'Board'
require_relative 'HumanPlayer'
require_relative 'ComputerPlayer'

class Game
    attr_reader :previous_guess
    def initialize(size=4, player_type='h')
        raise "Invalid size, should be even!" if size % 2 != 0
        @board = Board.new(size)
        @previous_guess = nil

        @board.populate
        case player_type.downcase
        when 'h'
            @player = HumanPlayer.new(@board.size)
        when 'c'
            @player = ComputerPlayer.new(@board.size)
        else
            raise 'Not valid player type, only `h` or `c`'
        end
    end

    def valid_pos?(pos)
        size = @board.size
        return pos.is_a?(Array) &&
            pos.length == 2 && 
            pos.all? { |el| el.between?(0, @board.size-1) } &&
            not_revealed_card_at_pos?(pos)
    end

    def not_revealed_card_at_pos?(pos)
        card = @board[pos]
        return !card.revealed?
    end

    def make_guess(pos)
        guessed_pos = get_player_input
        guessed_pos
    end

    def get_player_input
        pos = nil
        until pos && valid_pos?(pos)
            pos = @player.get_input
        end

        pos
    end

    def play
        while !over?
            clear_and_render
            guessed_pos = get_player_input
            @board.reveal(guessed_pos)
            compare_guess(guessed_pos)
        end
        puts "You Won!!!"
    end

    def compare_guess(guessed_pos)
        if not @previous_guess
            @previous_guess = guessed_pos
            @player.previous_guess = guessed_pos
            return
        elsif @board[guessed_pos] != @board[@previous_guess]
            clear_and_render
            sleep(2)
            hide_cards(guessed_pos, @previous_guess)
        end
        @player.receive_match(previous_guess, guessed_pos) if @board[guessed_pos] == @board[@previous_guess]
        @previous_guess = nil
        @player.previous_guess = nil
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
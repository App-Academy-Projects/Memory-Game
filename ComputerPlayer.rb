class ComputerPlayer
    attr_accessor :previous_guess
    def initialize(board)
        @board = board
        @previous_guess = nil
        @known_cards = {}
        @matched_cards = {}
    end

    def get_input
        if @previous_guess
            second_guess
        else
            first_guess
        end
    end

    def receive_revealed_card(pos, card_val)
        @known_cards[pos] = card_val
    end

    def receive_match(pos1, pos2)
        @matched_cards[pos1] = true
        @matched_cards[pos2] = true
    end

    def match_previous
        (pos, _) = @known_cards.find do |pos, val|
            pos != @previous_guess && val == @known_cards[@previous_guess] &&
                !@matched_cards[pos]
        end

        pos
    end

    def unmatch_previous
        (pos, _) = @known_cards.find do |pos, val|
            @known_cards.any? do |pos2, val2|
                (pos != pos2 && val == val2) &&
                !(@matched_cards[pos] || @matched_cards[pos2])
            end
        end

        pos
    end

    def first_guess
        unmatch_previous || rand_guess
    end

    def second_guess
        match_previous || rand_guess
    end

    def rand_guess
        size = @board.size
        guess = nil
        until guess && !@known_cards[guess]
            guess = [rand(size), rand(size)]
        end
        guess
    end
end
require_relative 'Game'

class HumanPlayer
    attr_accessor :previous_guess
    def initialize(size)
        @size = size
        @previous_guess = nil
    end
    
    def get_input
        prompt
        make_pos(gets.chomp.split)
    end

    def prompt
        puts
        print "Enter a position of card you want to flip ex.`1 2`: "
    end

    def make_pos(pos)
        pos = pos[0].to_i, pos[1].to_i
        pos
    end

    def receive_revealed_card(pos, value)
        
    end

    def receive_match(pos1, pos2)
        puts "It's a match!"
    end
end
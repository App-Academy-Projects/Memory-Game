require_relative 'Card'

ALPHAPETS = ("A".."Z").to_a
class Board
    attr_accessor :grid, :size
    def initialize(size)
        @size = size
        @grid = Array.new(size) { Array.new(size, nil) }
    end

    def populate
        ((size**2)/2).times do
            card = rand_card
            pos1 = generate_pos_unless_not_empty
            assign_rand_card_to_positions(pos1, card)
            pos2 = generate_pos_unless_not_empty
            assign_rand_card_to_positions(pos2, card)
        end
    end
    
    def assign_rand_card_to_positions(pos, card)
        self[pos] = Card.new(card)
    end

    def generate_pos
        pos = rand(size), rand(size)
    end

    def rand_card
        ALPHAPETS.sample
    end

    def empty_pos?(pos)
        self[pos].nil?
    end

    def generate_pos_unless_not_empty
        pos = generate_pos
        while not empty_pos?(pos)
            pos = generate_pos
        end
        pos
    end

    def print_board_cord
        print "  "
        size.times { |i| print "#{i} " }
    end

    def print_card(card)
        if card.revealed?
            print card.face
        else
            print " "
        end
        print " "
    end

    def render
        print_board_cord
        puts
        (0...size).each do |row|
            print "#{row} "
            (0...size).each do |col|
                pos = [row, col]
                card = self[pos]
                print_card(card)
            end
            puts
        end
    end

    def won?
        @grid.all? { |cards| cards.all? { |card| card.revealed? } }
    end

    def reveal(guessed_pos)
        card = self[guessed_pos]
        card.reveal
        return card.face
    end

    def [](pos)
        row, col = pos[0], pos[1]
        @grid[row][col]
    end

    def []=(pos, value)
        row, col = pos[0], pos[1]
        @grid[row][col] = value
    end
end
module NASA
  class Rover
    ORIENTATIONS = "NESW"

    attr_reader :x, :y, :orientation

    def initialize(plateau, x, y, orientation)
      raise "Invalid orientation: `#{orientation}`" unless ORIENTATIONS.include?(orientation)
      @plateau, @x, @y, @orientation = plateau, x, y, orientation
    end

    def advance!
      x, y = next_position(@orientation)
      if @plateau.valid_position?(x, y)
        @x, @y = x, y
      end
    end

    def turn_left!
      turn!(-1)
    end

    def turn_right!
      turn!(1)
    end

    private

    def next_position(orientation)
      x, y = @x, @y
      case orientation
        when "N"
          y += 1
        when "S"
          y -= 1
        when "E"
          x += 1
        when "W"
          x -= 1
      end
      [x, y]
    end

    def turn!(offset)
      index = ORIENTATIONS.index(@orientation) + offset
      @orientation = ORIENTATIONS[index >= ORIENTATIONS.size ? 0 : index]
    end
  end
end

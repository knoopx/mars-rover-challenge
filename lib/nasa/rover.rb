module NASA
  class Rover
    ORIENTATIONS = "NESW"

    attr_reader :x, :y, :orientation

    def initialize(x, y, orientation)
      @x, @y, @orientation = x, y, orientation
    end

    def advance!
      case @orientation
        when "N"
          @y += 1
        when "S"
          @y -= 1
        when "E"
          @x += 1
        when "W"
          @x -= 1
      end
    end

    def turn_left!
      turn!(-1)
    end

    def turn_right!
      turn!(1)
    end

    private

    def turn!(offset)
      index = ORIENTATIONS.index(@orientation) + offset
      @orientation = ORIENTATIONS[index >= ORIENTATIONS.size ? 0 : index]
    end
  end
end

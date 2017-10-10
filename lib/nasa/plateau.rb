require 'nasa/rover'

module NASA
  class Plateau
    attr_reader :width, :height, :rovers

    def initialize(width, height)
      @rovers = []
      @width, @height = width, height
    end

    def deploy(x, y, orientation)
      rover = Rover.new(self, x, y, orientation)
      @rovers.push(rover)
      rover
    end

    def valid_position?(x, y)
      within_bounds?(x, y) && available_position?(x, y)
    end

    def within_bounds?(x, y)
      (0..@width).include?(x) && (0..@height).include?(y)
    end

    def available_position?(x, y)
      @rovers.none?{|rover| rover.x == x && rover.y == y}
    end
  end
end

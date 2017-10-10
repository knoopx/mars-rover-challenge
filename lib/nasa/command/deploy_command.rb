module NASA
  module Command
    class DeployCommand
      attr_reader :x, :y, :orientation

      def initialize(x, y, orientation)
        @x, @y, @orientation = x, y, orientation
      end

      def execute(commander)
        commander.deploy(@x, @y, @orientation)
      end
    end
  end
end

require 'nasa/plateau'

module NASA
  module Command
    class InitializeCommand
      attr_reader :width, :height

      def initialize(width, height)
        @width, @height = width, height
      end

      def execute(commander)
        commander.initialize_plateau(@width, @height)
      end
    end
  end
end

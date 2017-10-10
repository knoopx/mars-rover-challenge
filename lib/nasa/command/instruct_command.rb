module NASA
  module Command
    class InstructCommand
      attr_reader :instructions

      def initialize(instructions)
        @instructions = instructions
      end

      def execute(commander)
        @instructions.each do |instruction|
          case instruction
            when "M"
              commander.last_deployed_rover.advance!
            when "R"
              commander.last_deployed_rover.turn_right!
            when "L"
              commander.last_deployed_rover.turn_left!
          end
        end
      end
    end
  end
end

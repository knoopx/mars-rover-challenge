require 'nasa/command/deploy_command'
require 'nasa/command/initialize_command'
require 'nasa/command/instruct_command'

module NASA
  module Parser
    class TextParser
      def initialize
        @state = :initializing
      end

      def parse_command(command)
        case @state
          when :initializing
            # 5 5
            width, height = parse(command, /\A(\d+) (\d+)\z/)
            @state = :deploying
            Command::InitializeCommand.new(width.to_i, height.to_i)
          when :deploying
            # 1 2 N
            x, y, orientation = parse(command, /\A(\d+) (\d+) (N|S|E|W)\z/)
            @state = :awaiting_instructions
            Command::DeployCommand.new(x.to_i, y.to_i, orientation)
          when :awaiting_instructions
            # LMLMLMLMM
            # MMRMMRMRRM
            sequence = parse(command, /\A([LRM]+)\z/)
            @state = :deploying
            Command::InstructCommand.new(sequence.first.chars)
        end
      end

      private

      def parse(command, regex)
        match = command.match(regex)
        raise "Unexpected command: `#{command}`" unless match
        match.captures
      end
    end
  end
end

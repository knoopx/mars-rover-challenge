require 'nasa/rover'

module NASA
  class Commander
    attr_reader :width, :height, :rovers

    def initialize
      @rovers = []
      @state = :initializing
    end

    def execute(command)
      case @state
        when :initializing
          # 5 5
          width, height = parse_command!(command, /\A(\d+) (\d+)\z/)
          initialize!(width.to_i, height.to_i)
        when :deploying
          # 1 2 N
          x, y, orientation = parse_command!(command, /\A(\d+) (\d+) (N|S|E|W)\z/)
          deploy!(x.to_i, y.to_i, orientation)
        when :awaiting_instructions
          # LMLMLMLMM
          # MMRMMRMRRM
          sequence = parse_command!(command, /\A([LRM]+)\z/)
          execute_instructions!(sequence.first.chars)
      end
    end

    def report
      raise "No rovers were deployed" if @rovers.none?
      @rovers.map{|rover| [rover.x, rover.y, rover.orientation].join(" ") }.join("\n")
    end

    private

    def parse_command!(command, regex)
      match = command.match(regex)
      raise "Unexpected command: `#{command}`" unless match
      match.captures
    end

    def initialize!(width, height)
      @width, @height = width, height
      @state = :deploying
    end

    def deploy!(x, y, orientation)
      @rovers.push(Rover.new(x, y, orientation))
      @state = :awaiting_instructions
    end

    def execute_instructions!(instructions)
      instructions.each do |instruction|
        case instruction
          when "M"
            @rovers.last.advance!
          when "R"
            @rovers.last.turn_right!
          when "L"
            @rovers.last.turn_left!
        end
      end
      @state = :deploying
    end
  end
end

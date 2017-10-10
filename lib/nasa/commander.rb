require 'nasa/rover'

module NASA
  class Commander
    attr_reader :plateau, :last_deployed_rover

    def execute(*commands)
      commands.each{|command| command.execute(self) }
    end

    def initialize_plateau(width, height)
      @plateau = Plateau.new(width, height)
    end

    def deploy(x, y, orientation)
      @last_deployed_rover = @plateau.deploy(x, y, orientation)
    end

    def report
      raise "Plateau not initialized" if @plateau.nil?
      raise "No rovers were deployed" if @plateau.rovers.none?
      @plateau.rovers.map{|rover| [rover.x, rover.y, rover.orientation].join(" ") }.join("\n")
    end
  end
end

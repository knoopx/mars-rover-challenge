require 'spec_helper'
require 'nasa/commander'

RSpec.describe NASA::Commander do
  describe "#execute" do
    context "initialization" do
      it "initializes the plateau" do
        subject.execute(NASA::Command::InitializeCommand.new(5, 5))
        expect(subject.plateau.width).to eq(5)
        expect(subject.plateau.height).to eq(5)
      end
    end

    context "deployment" do
      before { subject.execute(NASA::Command::InitializeCommand.new(5, 5)) }

      it "deploys rovers" do
        subject.execute(NASA::Command::DeployCommand.new(1, 2, "N"))
        expect(subject.last_deployed_rover).not_to be_nil
        expect(subject.plateau.rovers.size).to eq(1)
        expect(subject.plateau.rovers.first.x).to eq(1)
        expect(subject.plateau.rovers.first.y).to eq(2)
        expect(subject.plateau.rovers.first.orientation).to eq("N")
        subject.execute(NASA::Command::InstructCommand.new(["L", "M", "L", "M", "L", "M", "L", "M", "M"]))
        expect(subject.plateau.rovers.size).to eq(1)
        expect(subject.plateau.rovers.first.x).to eq(1)
        expect(subject.plateau.rovers.first.y).to eq(3)
        expect(subject.plateau.rovers.first.orientation).to eq("N")
      end
    end
  end

  describe "#report" do
    it "throws when no rovers deployed" do
      expect{ subject.report }.to raise_error(/Plateau not initialized/)
    end

    context do
      before { subject.initialize_plateau(5, 5)}

      it "throws when no rovers deployed" do
        expect{ subject.report }.to raise_error(/No rovers were deployed/)
      end

      context do
        before do
          subject.execute(
            NASA::Command::DeployCommand.new(1, 2, "N"),
            NASA::Command::InstructCommand.new(["L", "M", "L", "M", "L", "M", "L", "M", "M"]),
            NASA::Command::DeployCommand.new(3, 3, "E"),
            NASA::Command::InstructCommand.new(["M", "M", "R", "M", "M", "R", "M", "R", "R", "M"]),
          )
        end

        it "reports rovers positions" do
          expect(subject.report).to eq(["1 3 N", "5 1 E"].join("\n"))
        end
      end
    end
  end
end

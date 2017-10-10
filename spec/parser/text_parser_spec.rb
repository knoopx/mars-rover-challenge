require 'spec_helper'
require 'nasa/parser/text_parser'

RSpec.describe NASA::Parser::TextParser do
  describe "#parse" do
    context "initialization" do
      it "throws on unexpected input" do
        expect{ subject.parse_command("abc") }.to raise_error(/Unexpected command/)
      end

      it "successfully parses" do
        command = subject.parse_command("5 5")
        expect(command).to be_an_instance_of(NASA::Command::InitializeCommand)
        expect(command.width).to eq(5)
        expect(command.height).to eq(5)
      end
    end

    context "deployment" do
      before { subject.parse_command("5 5") }

      it "throws on unexpected input" do
        expect{ subject.parse_command("6 6 X") }.to raise_error(/Unexpected command/)
      end

      it "successfully parses" do
        command = subject.parse_command("1 2 N")
        expect(command).to be_an_instance_of(NASA::Command::DeployCommand)
        expect(command.x).to eq(1)
        expect(command.y).to eq(2)
        expect(command.orientation).to eq("N")

        command = subject.parse_command("LMLMLMLMM")
        expect(command).to be_an_instance_of(NASA::Command::InstructCommand)
        expect(command.instructions).to eq(["L", "M", "L", "M", "L", "M", "L", "M", "M"])
      end
    end
  end
end

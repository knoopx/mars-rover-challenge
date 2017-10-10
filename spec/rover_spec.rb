require 'spec_helper'
require 'nasa/rover'

RSpec.describe NASA::Rover do
  let(:plateau){ NASA::Plateau.new(5, 5) }

  it "throws when initialized with an invalid orientation" do
    expect { NASA::Rover.new(plateau, 0, 0, "X") }.to raise_error(/Invalid orientation/)
  end

  describe "#turn_left!" do
    subject { NASA::Rover.new(plateau, 0, 0, "N") }

    it "turns orientation accordingly" do
      expect(subject.orientation).to eq("N")
      subject.turn_left!
      expect(subject.orientation).to eq("W")
      subject.turn_left!
      expect(subject.orientation).to eq("S")
      subject.turn_left!
      expect(subject.orientation).to eq("E")
      subject.turn_left!
      expect(subject.orientation).to eq("N")
    end
  end

  describe "#turn_right!" do
    subject { NASA::Rover.new(plateau, 0, 0, "N") }

    it "turns orientation accordingly" do
      expect(subject.orientation).to eq("N")
      subject.turn_right!
      expect(subject.orientation).to eq("E")
      subject.turn_right!
      expect(subject.orientation).to eq("S")
      subject.turn_right!
      expect(subject.orientation).to eq("W")
      subject.turn_right!
      expect(subject.orientation).to eq("N")
    end
  end

  describe "#advance!" do
    subject { NASA::Rover.new(plateau, 0, 0, "N") }

    it "increments/decrements x and y accordingly" do
      subject.advance!
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(1)
      subject.turn_right!
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(1)
      subject.advance!
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(1)
    end

    it "does not advance to out of bound positions" do
      expect(subject.y).to eq(0)
      6.times{ subject.advance! }
      expect(subject.y).to eq(5)
    end

    it "does not advance to unavailable positions" do
      plateau.deploy(0, 2, "N")
      expect(subject.y).to eq(0)
      6.times{ subject.advance! }
      expect(subject.y).to eq(1)
    end
  end
end

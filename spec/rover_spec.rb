require 'nasa/rover'

RSpec.describe NASA::Rover do
  subject { NASA::Rover.new(0,0, "N") }

  describe "#turn_left!" do
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
  end
end

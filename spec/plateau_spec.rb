require 'spec_helper'
require 'nasa/plateau'

RSpec.describe NASA::Plateau do
  subject { NASA::Plateau.new(10, 10) }

  describe "#within_bounds?" do
    it "returns false on invalid x" do
      expect(subject.within_bounds?(-1, 0)).to eq(false)
    end

    it "returns false on invalid y" do
      expect(subject.within_bounds?(0, -1)).to eq(false)
    end

    it "returns true on valid position" do
      expect(subject.within_bounds?(10, 10)).to eq(true)
    end
  end

  describe "#available_position?" do
    before { subject.deploy(1, 1, "N") }
    it "returns false on unavailable position" do
      expect(subject.available_position?(1, 1)).to eq(false)
    end

    it "returns true on available position" do
      expect(subject.available_position?(10, 10)).to eq(true)
    end
  end
end

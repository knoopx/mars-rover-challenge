require 'spec_helper'
require 'nasa/commander'

RSpec.describe NASA::Commander do
  context "initialization" do
    it "throws on unexpected input" do
      expect{ subject.execute("abc") }.to raise_error(/Unexpected command/)
    end

    it "initializes the plateau" do
      subject.execute("5 5")
      expect(subject.width).to eq(5)
      expect(subject.height).to eq(5)
    end
  end

  context "deployment" do
    before { subject.execute("5 5") }

    it "throws on unexpected input" do
      expect{ subject.execute("6 6 X") }.to raise_error(/Unexpected command/)
    end

    it "deploys rovers" do
      subject.execute("1 2 N")
      expect(subject.rovers.size).to eq(1)
      expect(subject.rovers.first.x).to eq(1)
      expect(subject.rovers.first.y).to eq(2)
      expect(subject.rovers.first.orientation).to eq("N")
      subject.execute("LMLMLMLMM")
      expect(subject.rovers.size).to eq(1)
      expect(subject.rovers.first.x).to eq(1)
      expect(subject.rovers.first.y).to eq(3)
      expect(subject.rovers.first.orientation).to eq("N")
    end
  end

  describe "#report" do
    before do
      subject.execute("5 5")
      subject.execute("1 2 N")
      subject.execute("LMLMLMLMM")
      subject.execute("3 3 E")
      subject.execute("MMRMMRMRRM")
    end

    it "reports rovers positions" do
      expect(subject.report).to eq(["1 3 N", "5 1 E"].join("\n"))
    end
  end
end

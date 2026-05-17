# frozen_string_literal: true

RSpec.describe Ashtu::Dictionary do
  subject { described_class.new }

  describe "#lookup" do
    it "returns an entry for a known word" do
      entry = subject.lookup("dog")
      expect(entry).to have_attributes(word: "dog", part_of_speech: "noun", definition: "dog")
    end

    it "returns nil for an unknown word" do
      expect(subject.lookup("xyz")).to be_nil
    end
  end

  describe "#search" do
    it "returns entries matching the English term" do
      results = subject.search("fire")
      expect(results).to contain_exactly(
        have_attributes(word: "faia"),
        have_attributes(word: "smoke")
      )
    end

    it "returns an empty array when no matches" do
      expect(subject.search("xyzxyz")).to be_empty
    end
  end
end

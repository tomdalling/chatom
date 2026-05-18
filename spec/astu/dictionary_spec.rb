# frozen_string_literal: true

RSpec.describe Astu::Dictionary do
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
        have_attributes(word: "smok")
      )
    end

    it "returns an empty array when no matches" do
      expect(subject.search("xyzxyz")).to be_empty
    end
  end

  describe "transitivity" do
    it "parses transitive verbs" do
      expect(subject.lookup("si")).to have_attributes(transitivity: :transitive)
    end

    it "parses intransitive verbs" do
      expect(subject.lookup("slip")).to have_attributes(transitivity: :intransitive)
    end

    it "parses verbs that can be both" do
      expect(subject.lookup("drink")).to have_attributes(transitivity: :both)
    end

    it "leaves transitivity nil for non-verbs" do
      expect(subject.lookup("dog")).to have_attributes(transitivity: nil)
    end
  end

  describe "#list" do
    it "returns all entries when no pos filter given" do
      results = subject.list
      expect(results).not_to be_empty
      expect(results).to include(have_attributes(word: "dog"), have_attributes(word: "si"))
    end

    it "returns only entries matching the given pos" do
      results = subject.list(pos: "verb")
      expect(results).to all(have_attributes(part_of_speech: "verb"))
      expect(results).to include(have_attributes(word: "si"))
      expect(results).not_to include(have_attributes(word: "dog"))
    end

    it "returns an empty array for an unknown pos" do
      expect(subject.list(pos: "unknown_pos")).to be_empty
    end
  end
end

# frozen_string_literal: true

RSpec.describe Ashtu::Parser do
  subject { described_class }

  let(:dictionary) { Ashtu::Dictionary.new }

  describe ".parse" do
    it "parses a valid SVO sentence into an AST::Clause" do
      result = subject.parse("mi si dog", dictionary: dictionary)
      expect(result).to be_a(Ashtu::AST::Clause)
      expect(result.subject.head.root).to eq("mi")
      expect(result.predicate.head.root).to eq("si")
      expect(result.predicate.direct_object.head.root).to eq("dog")
    end

    it "raises for an unknown word" do
      expect {
        subject.parse("mi si xyz", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Unknown word: xyz/)
    end

    it "raises when not exactly 3 tokens" do
      expect {
        subject.parse("mi si", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected exactly 3 words/)
    end

    it "raises when too many tokens" do
      expect {
        subject.parse("mi si dog dog", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected exactly 3 words/)
    end

    it "raises when subject is not a noun or pronoun" do
      expect {
        subject.parse("si mi dog", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected noun or pronoun as subject/)
    end

    it "raises when predicate is not a verb" do
      expect {
        subject.parse("mi dog si", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected verb as predicate/)
    end

    it "raises when object is not a noun or pronoun" do
      expect {
        subject.parse("mi si si", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected noun or pronoun as object/)
    end

    it "accepts pronouns as subject and object" do
      result = subject.parse("mi si mi", dictionary: dictionary)
      expect(result).to be_a(Ashtu::AST::Clause)
    end
  end
end

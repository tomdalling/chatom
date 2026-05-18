# frozen_string_literal: true

RSpec.describe Astu::Parser do
  subject { described_class }

  let(:dictionary) { Astu::Dictionary.new }

  describe ".parse" do
    it "parses a valid SVO sentence into an AST::Clause" do
      result = subject.parse("mi si dog", dictionary: dictionary)
      expect(result).to be_a(Astu::AST::Clause)
      expect(result.subject.nouns.first.root).to eq("mi")
      expect(result.predicate.head.root).to eq("si")
      expect(result.predicate.direct_object.nouns.first.root).to eq("dog")
    end

    it "raises for an unknown word" do
      expect {
        subject.parse("mi si xyz", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Unknown word: xyz/)
    end

    it "parses an intransitive sentence (subject + verb only)" do
      result = subject.parse("mi slip", dictionary: dictionary)
      expect(result).to be_a(Astu::AST::Clause)
      expect(result.subject.nouns.first.root).to eq("mi")
      expect(result.predicate.head.root).to eq("slip")
      expect(result.predicate.direct_object).to be_nil
    end

    it "parses a sentence with an adjective on the object" do
      result = subject.parse("mi si dog smol", dictionary: dictionary)
      expect(result.subject.nouns.first.root).to eq("mi")
      expect(result.subject.adjectives).to be_empty
      expect(result.predicate.head.root).to eq("si")
      expect(result.predicate.direct_object.nouns.first.root).to eq("dog")
      expect(result.predicate.direct_object.adjectives.map(&:root)).to eq(["smol"])
    end

    it "parses an intransitive sentence with an adjective on the subject" do
      result = subject.parse("berd smol flai", dictionary: dictionary)
      expect(result.subject.nouns.first.root).to eq("berd")
      expect(result.subject.adjectives.map(&:root)).to eq(["smol"])
      expect(result.predicate.head.root).to eq("flai")
      expect(result.predicate.direct_object).to be_nil
    end

    it "parses a sentence with adjectives on both subject and object" do
      result = subject.parse("berd smol si dog smol", dictionary: dictionary)
      expect(result.subject.nouns.first.root).to eq("berd")
      expect(result.subject.adjectives.map(&:root)).to eq(["smol"])
      expect(result.predicate.head.root).to eq("si")
      expect(result.predicate.direct_object.nouns.first.root).to eq("dog")
      expect(result.predicate.direct_object.adjectives.map(&:root)).to eq(["smol"])
    end

    it "raises when no verb in sentence" do
      expect {
        subject.parse("mi dog", dictionary: dictionary)
      }.to raise_error(ArgumentError, /No verb found/)
    end

    it "raises when only 1 token" do
      expect {
        subject.parse("mi", dictionary: dictionary)
      }.to raise_error(ArgumentError)
    end

    it "raises when verb has no subject" do
      expect {
        subject.parse("si mi dog", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected noun or pronoun as subject/)
    end

    it "raises when object is not a noun or pronoun" do
      expect {
        subject.parse("mi si si", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected noun or pronoun as object/)
    end

    it "parses a noun phrase with a modifier noun" do
      result = subject.parse("eg berd si mi", dictionary: dictionary)
      expect(result.subject.nouns.first.root).to eq("eg")
      expect(result.subject.nouns[1..].map(&:root)).to eq(["berd"])
      expect(result.subject.adjectives).to be_empty
    end

    it "parses a noun phrase with a modifier noun and adjectives" do
      result = subject.parse("eg berd smol si mi", dictionary: dictionary)
      expect(result.subject.nouns.first.root).to eq("eg")
      expect(result.subject.nouns[1..].map(&:root)).to eq(["berd"])
      expect(result.subject.adjectives.map(&:root)).to eq(["smol"])
    end

    it "raises when a noun follows an adjective in the subject noun phrase" do
      expect {
        subject.parse("mi smol dog si", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected adjective in subject noun phrase/)
    end

    it "raises when a noun follows an adjective in the object noun phrase" do
      expect {
        subject.parse("mi si dog smol berd", dictionary: dictionary)
      }.to raise_error(ArgumentError, /Expected adjective in object noun phrase/)
    end

    it "accepts pronouns as subject and object" do
      result = subject.parse("mi si mi", dictionary: dictionary)
      expect(result).to be_a(Astu::AST::Clause)
    end
  end
end

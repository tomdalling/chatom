# frozen_string_literal: true

RSpec.describe Ashtu::CLI do
  let(:dictionary) { instance_double(Ashtu::Dictionary) }
  subject { described_class.new(dictionary: dictionary) }

  describe "#run" do
    describe "lookup" do
      let(:entry) { Ashtu::Dictionary::Entry.new(word: "dog", part_of_speech: "noun", definition: "dog") }

      it "prints the entry when found" do
        allow(dictionary).to receive(:lookup).with("dog").and_return(entry)
        expect { subject.run(["lookup", "dog"]) }.to output("dog [noun] dog\n").to_stdout
      end

      it "prints a message when not found" do
        allow(dictionary).to receive(:lookup).with("xyz").and_return(nil)
        expect { subject.run(["lookup", "xyz"]) }.to output("Word not found: xyz\n").to_stdout
      end
    end

    describe "search" do
      it "prints matching entries" do
        entries = [Ashtu::Dictionary::Entry.new(word: "faia", part_of_speech: "noun", definition: "fire")]
        allow(dictionary).to receive(:search).with("fire").and_return(entries)
        expect { subject.run(["search", "fire"]) }.to output("faia [noun] fire\n").to_stdout
      end

      it "prints nothing when no matches" do
        allow(dictionary).to receive(:search).with("xyz").and_return([])
        expect { subject.run(["search", "xyz"]) }.to output("").to_stdout
      end
    end
  end
end

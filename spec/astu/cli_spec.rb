# frozen_string_literal: true

RSpec.describe Astu::CLI do
  let(:dictionary) { instance_double(Astu::Dictionary) }
  subject { described_class.new(dictionary: dictionary) }

  describe "#run" do
    describe "help" do
      it "prints help with no args" do
        expect { subject.run([]) }.to output(/Usage: astu/).to_stdout
      end

      it "prints help with -h" do
        expect { subject.run(["-h"]) }.to output(/Usage: astu/).to_stdout
      end

      it "prints help with --help" do
        expect { subject.run(["--help"]) }.to output(/Usage: astu/).to_stdout
      end
    end

    describe "lookup" do
      let(:entry) { Astu::Dictionary::Entry.new(word: "dog", part_of_speech: "noun", definition: "dog") }

      it "prints the entry when found" do
        allow(dictionary).to receive(:lookup).with("dog").and_return(entry)
        expect { subject.run(["lookup", "dog"]) }.to output("dog [noun] /dog/ dog\n").to_stdout
      end

      it "prints a message when not found" do
        allow(dictionary).to receive(:lookup).with("xyz").and_return(nil)
        expect { subject.run(["lookup", "xyz"]) }.to output("Word not found: xyz\n").to_stdout
      end

      it "prints usage with -h" do
        expect { subject.run(["lookup", "-h"]) }.to output(/Usage: astu lookup/).to_stdout
      end

      it "prints usage with --help" do
        expect { subject.run(["lookup", "--help"]) }.to output(/Usage: astu lookup/).to_stdout
      end
    end

    describe "list" do
      let(:noun_entry) { Astu::Dictionary::Entry.new(word: "dog", part_of_speech: "noun", definition: "dog") }
      let(:verb_entry) { Astu::Dictionary::Entry.new(word: "si", part_of_speech: "verb", definition: "see") }

      it "prints all entries when called with no args" do
        allow(dictionary).to receive(:list).with(pos: nil).and_return([noun_entry, verb_entry])
        expect { subject.run(["list"]) }.to output("dog [noun] /dog/ dog\nsi [verb] /si/ see\n").to_stdout
      end

      it "prints only matching entries when --pos is given" do
        allow(dictionary).to receive(:list).with(pos: "noun").and_return([noun_entry])
        expect { subject.run(["list", "--pos", "noun"]) }.to output("dog [noun] /dog/ dog\n").to_stdout
      end

      it "prints nothing for an unknown pos" do
        allow(dictionary).to receive(:list).with(pos: "unknown").and_return([])
        expect { subject.run(["list", "--pos", "unknown"]) }.to output("").to_stdout
      end

      it "prints usage with -h" do
        expect { subject.run(["list", "-h"]) }.to output(/Usage: astu list/).to_stdout
      end

      it "prints usage with --help" do
        expect { subject.run(["list", "--help"]) }.to output(/Usage: astu list/).to_stdout
      end
    end

    describe "search" do
      it "prints matching entries" do
        entries = [Astu::Dictionary::Entry.new(word: "faia", part_of_speech: "noun", definition: "fire")]
        allow(dictionary).to receive(:search).with("fire").and_return(entries)
        expect { subject.run(["search", "fire"]) }.to output("faia [noun] /faia/ fire\n").to_stdout
      end

      it "prints nothing when no matches" do
        allow(dictionary).to receive(:search).with("xyz").and_return([])
        expect { subject.run(["search", "xyz"]) }.to output("").to_stdout
      end

      it "prints usage with -h" do
        expect { subject.run(["search", "-h"]) }.to output(/Usage: astu search/).to_stdout
      end

      it "prints usage with --help" do
        expect { subject.run(["search", "--help"]) }.to output(/Usage: astu search/).to_stdout
      end
    end
  end
end

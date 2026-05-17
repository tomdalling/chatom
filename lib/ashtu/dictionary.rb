# frozen_string_literal: true

module Ashtu
  class Dictionary
    Entry = Data.define(:word, :part_of_speech, :definition)

    DEFAULT_PATH = File.expand_path("../../data/dictionary.txt", __dir__)

    def initialize(path = DEFAULT_PATH)
      @entries = parse(path)
    end

    def lookup(word)
      @entries.find { _1.word == word }
    end

    def search(query)
      @entries.select { _1.definition.include?(query) }
    end

    private

    def parse(path)
      File.readlines(path, chomp: true).filter_map do |line|
        next if line.empty? || line.start_with?("#")
        next unless line =~ /^(\S+)\s+\[(\w+)\]\s+(.+)$/
        Entry.new(word: $1, part_of_speech: $2, definition: $3.strip)
      end
    end
  end
end

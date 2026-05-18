# frozen_string_literal: true

module Ashtu
  class Dictionary
    Entry = Data.define(:word, :part_of_speech, :definition, :description) do
      def initialize(word:, part_of_speech:, definition:, description: nil)
        super
      end
    end

    DEFAULT_PATH = File.expand_path("../../data/dictionary.txt", __dir__)

    def initialize(path = DEFAULT_PATH)
      @entries = parse(path)
    end

    def lookup(word)
      @entries.find { _1.word == word }
    end

    def search(query)
      @entries.select { _1.definition.include?(query) || _1.description&.include?(query) }
    end

    def list(pos: nil)
      pos ? @entries.select { _1.part_of_speech == pos } : @entries
    end

    private

    def parse(path)
      entries = []
      pending = nil

      File.readlines(path, chomp: true).each do |line|
        if line =~ /^(\S+)\s+\[(\w+)\]\s+(.+)$/
          entries << Entry.new(**pending) if pending
          pending = { word: $1, part_of_speech: $2, definition: $3.strip, description: nil }
        elsif line =~ /^\s+\S/ && pending
          pending[:description] = line.strip
        end
      end
      entries << Entry.new(**pending) if pending
      entries
    end
  end
end

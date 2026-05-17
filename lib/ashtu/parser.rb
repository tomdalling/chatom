# frozen_string_literal: true

module Ashtu
  module Parser
    extend self

    NOUN_POS = %w[noun pronoun].freeze

    def parse(text, dictionary:)
      tokens = text.split
      raise ArgumentError, "Expected exactly 3 words, got #{tokens.size}" unless tokens.size == 3

      entries = tokens.map do |token|
        dictionary.lookup(token) or raise ArgumentError, "Unknown word: #{token}"
      end

      subject_entry, verb_entry, object_entry = entries

      unless NOUN_POS.include?(subject_entry.part_of_speech)
        raise ArgumentError, "Expected noun or pronoun as subject, got: #{subject_entry.part_of_speech}"
      end
      unless verb_entry.part_of_speech == "verb"
        raise ArgumentError, "Expected verb as predicate, got: #{verb_entry.part_of_speech}"
      end
      unless NOUN_POS.include?(object_entry.part_of_speech)
        raise ArgumentError, "Expected noun or pronoun as object, got: #{object_entry.part_of_speech}"
      end

      AST::Clause.new(
        subject: AST::NounPhrase.new(head: AST::Noun.new(root: subject_entry.word)),
        predicate: AST::VerbPhrase.new(
          head: AST::Verb.new(root: verb_entry.word),
          direct_object: AST::NounPhrase.new(head: AST::Noun.new(root: object_entry.word)),
        ),
      )
    end
  end
end

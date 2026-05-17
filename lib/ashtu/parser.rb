# frozen_string_literal: true

module Ashtu
  module Parser
    extend self

    NOUN_POS = %w[noun pronoun].freeze

    def parse(text, dictionary:)
      tokens = text.split
      unless tokens.size.between?(2, 3)
        raise ArgumentError, "Expected 2 or 3 words, got #{tokens.size}"
      end

      entries = tokens.map do |token|
        dictionary.lookup(token) or raise ArgumentError, "Unknown word: #{token}"
      end

      subject_entry = entries[0]
      verb_entry = entries[1]
      object_entry = entries[2]

      unless NOUN_POS.include?(subject_entry.part_of_speech)
        raise ArgumentError, "Expected noun or pronoun as subject, got: #{subject_entry.part_of_speech}"
      end
      unless verb_entry.part_of_speech == "verb"
        raise ArgumentError, "Expected verb as predicate, got: #{verb_entry.part_of_speech}"
      end
      if object_entry && !NOUN_POS.include?(object_entry.part_of_speech)
        raise ArgumentError, "Expected noun or pronoun as object, got: #{object_entry.part_of_speech}"
      end

      direct_object = object_entry && AST::NounPhrase.new(head: AST::Noun.new(root: object_entry.word))

      AST::Clause.new(
        subject: AST::NounPhrase.new(head: AST::Noun.new(root: subject_entry.word)),
        predicate: AST::VerbPhrase.new(
          head: AST::Verb.new(root: verb_entry.word),
          direct_object: direct_object,
        ),
      )
    end
  end
end

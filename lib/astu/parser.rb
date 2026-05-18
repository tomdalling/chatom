# frozen_string_literal: true

module Astu
  module Parser
    extend self

    NOUN_POS = %w[noun pronoun].freeze

    def parse(text, dictionary:)
      tokens = text.split

      entries = tokens.map do |token|
        dictionary.lookup(token) or raise ArgumentError, "Unknown word: #{token}"
      end

      verb_index = entries.index { _1.part_of_speech == "verb" }
      raise ArgumentError, "No verb found in sentence" unless verb_index
      raise ArgumentError, "Expected noun or pronoun as subject" if verb_index == 0

      subject_entries = entries[0...verb_index]
      verb_entry      = entries[verb_index]
      object_entries  = entries[(verb_index + 1)..]

      raise ArgumentError, "Expected a direct object after the verb" if object_entries.empty?

      subject       = build_noun_phrase(subject_entries, role: "subject")
      direct_object = build_noun_phrase(object_entries, role: "object")

      AST::Clause.new(
        subject: subject,
        predicate: AST::VerbPhrase.new(
          head: AST::Verb.new(root: verb_entry.word),
          direct_object: direct_object,
        ),
      )
    end

    private

    def build_noun_phrase(entries, role:)
      head_entry = entries[0]
      unless NOUN_POS.include?(head_entry.part_of_speech)
        raise ArgumentError, "Expected noun or pronoun as #{role}, got: #{head_entry.part_of_speech}"
      end

      rest = entries[1..]
      modifier_noun_entries = rest.take_while { NOUN_POS.include?(_1.part_of_speech) }
      adj_entries = rest.drop(modifier_noun_entries.size)

      adj_entries.each do |entry|
        unless entry.part_of_speech == "adjective"
          raise ArgumentError, "Expected adjective in #{role} noun phrase, got: #{entry.part_of_speech}"
        end
      end

      AST::NounPhrase.new(
        nouns:      ([head_entry] + modifier_noun_entries).map { AST::Noun.new(root: _1.word) },
        adjectives: adj_entries.map { AST::Adjective.new(root: _1.word) },
      )
    end
  end
end

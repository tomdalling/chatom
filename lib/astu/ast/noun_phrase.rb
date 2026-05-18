# frozen_string_literal: true

module Astu
  class AST::NounPhrase
    value_semantics do
      nouns      ArrayOf(AST::Noun)
      adjectives ArrayOf(AST::Adjective), default: []
    end

    def to_text
      (nouns + adjectives).map(&:to_text).join(" ")
    end

    def to_english_gloss(dictionary:)
      (adjectives + nouns.rotate(1)).map { _1.to_english_gloss(dictionary:) }.join(" ")
    end

    def to_xml_element(tag)
      Ox::Element.new(tag).tap do |el|
        nouns.each { el << _1.to_xml_element }
        adjectives.each { el << _1.to_xml_element }
      end
    end

    def self.from_xml_element(element)
      noun_elements = element.nodes.select { _1.is_a?(Ox::Element) && _1.value == 'Noun' }
      adj_elements  = element.nodes.select { _1.is_a?(Ox::Element) && _1.value == 'Adjective' }
      new(
        nouns:      noun_elements.map { AST::Noun.from_xml_element(_1) },
        adjectives: adj_elements.map { AST.parse_element(_1, AST::Adjective) },
      )
    end
  end
end

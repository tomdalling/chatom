# frozen_string_literal: true

module Ashtu
  class AST::NounPhrase
    value_semantics do
      head       AST::Noun
      adjectives ArrayOf(AST::Adjective), default: []
    end

    def to_text
      ([head.to_text] + adjectives.map(&:to_text)).join(" ")
    end

    def self.from_xml_element(element)
      adj_elements = element.nodes.select { _1.is_a?(Ox::Element) && _1.value == 'Adjective' }
      new(
        head: AST.parse_child_element(element, 'Noun'),
        adjectives: adj_elements.map { AST.parse_element(_1, AST::Adjective) },
      )
    end
  end
end

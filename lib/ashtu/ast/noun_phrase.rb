# frozen_string_literal: true

module Ashtu
  class AST::NounPhrase
    value_semantics do
      head AST::Noun
    end

    def to_text = head.to_text

    def self.from_xml_element(element)
      new(
        head: AST.parse_child_element(element, 'Noun'),
      )
    end
  end
end

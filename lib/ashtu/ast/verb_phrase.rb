# frozen_string_literal: true

module Ashtu
  class AST::VerbPhrase
    value_semantics do
      head AST::Verb
      direct_object AST::NounPhrase
    end

    def to_text = head.to_text + " " + direct_object.to_text

    def self.from_xml_element(element)
      new(
        head: AST.parse_child_element(element, 'Verb'),
        direct_object: AST.parse_child_element(element, 'DirectObject', AST::NounPhrase),
      )
    end
  end
end

# frozen_string_literal: true

module Astu
  class AST::VerbPhrase
    value_semantics do
      head AST::Verb
      direct_object AST::NounPhrase
    end

    def to_text
      "#{head.to_text} #{direct_object.to_text}"
    end

    def to_english_gloss(dictionary:)
      [head, direct_object].map { _1.to_english_gloss(dictionary:) }.join(" ")
    end

    def to_xml_element
      Ox::Element.new('Predicate').tap do |el|
        el << head.to_xml_element
        el << direct_object.to_xml_element('DirectObject')
      end
    end

    def self.from_xml_element(element)
      new(
        head: AST.parse_child_element(element, 'Verb'),
        direct_object: AST.parse_child_element(element, 'DirectObject', AST::NounPhrase),
      )
    end
  end
end

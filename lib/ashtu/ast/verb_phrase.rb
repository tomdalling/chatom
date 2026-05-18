# frozen_string_literal: true

module Ashtu
  class AST::VerbPhrase
    value_semantics do
      head AST::Verb
      direct_object Either(AST::NounPhrase, nil), default: nil
    end

    def to_text
      direct_object ? "#{head.to_text} #{direct_object.to_text}" : head.to_text
    end

    def to_english_gloss(dictionary:)
      [head, direct_object].compact.map { _1.to_english_gloss(dictionary:) }.join(" ")
    end

    def to_xml_element
      Ox::Element.new('Predicate').tap do |el|
        el << head.to_xml_element
        el << direct_object.to_xml_element('DirectObject') if direct_object
      end
    end

    def self.from_xml_element(element)
      do_elements = element.nodes.select { _1.is_a?(Ox::Element) && _1.value == 'DirectObject' }
      new(
        head: AST.parse_child_element(element, 'Verb'),
        direct_object: do_elements.empty? ? nil : AST.parse_element(do_elements.first, AST::NounPhrase),
      )
    end
  end
end

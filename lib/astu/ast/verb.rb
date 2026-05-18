# frozen_string_literal: true

module Astu
  class AST::Verb
    value_semantics do
      root String
    end

    def to_text = root

    def to_english_gloss(dictionary:)
      dictionary.lookup(root)&.definition || root
    end

    def to_xml_element
      Ox::Element.new('Verb').tap { _1 << root }
    end

    def self.from_xml_element(element)
      new(root: AST.parse_element_text(element))
    end
  end
end

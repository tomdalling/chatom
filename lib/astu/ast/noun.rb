module Astu
  class AST::Noun
    value_semantics do
      root String
    end

    def to_text = root.capitalize

    def to_english_gloss(dictionary:)
      dictionary.lookup(root)&.definition || root
    end

    def to_xml_element
      Ox::Element.new('Noun').tap { _1 << root }
    end

    def self.from_xml_element(element)
      new(root: AST.parse_element_text(element))
    end
  end
end

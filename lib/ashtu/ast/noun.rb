module Ashtu
  class AST::Noun
    value_semantics do
      root String
    end

    def to_text = root.capitalize

    def self.from_xml_element(element)
      new(root: AST.parse_element_text(element))
    end
  end
end

# frozen_string_literal: true

module Ashtu
  class AST::Verb
    value_semantics do
      root String
    end

    def to_text = root

    def self.from_xml_element(element)
      new(root: AST.parse_element_text(element))
    end
  end
end

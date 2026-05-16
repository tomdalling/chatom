# frozen_string_literal: true

module Ashtu
  class AST::Clause
    value_semantics do
      subject AST::NounPhrase
      predicate AST::VerbPhrase
    end

    def self.from_xml_element(element)
      new(
        subject: AST.parse_child_element(element, 'Subject', AST::NounPhrase),
        predicate: AST.parse_child_element(element, 'Predicate', AST::VerbPhrase),
      )
    end

    def to_text = subject.to_text + " " + predicate.to_text
  end
end

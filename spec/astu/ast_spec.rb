# frozen_string_literal: true

RSpec.describe Astu::AST, '#to_text' do
  describe '#to_text' do
    subject do
      ->(ast_xml) do
        described_class.parse_xml(ast_xml).to_text
      end
    end

    it 'serialises an AST to text' do
      expect(
        subject.(<<~AST)
          <Clause>
            <Subject>
              <Noun>dog</Noun>
            </Subject>
            <Predicate>
              <Verb>kil</Verb>
              <DirectObject>
                <Noun>bird</Noun>
              </DirectObject>
            </Predicate>
          </Clause>
        AST
      ).to eq("Dog kil Bird")
    end

    it 'serialises a noun phrase with a modifier noun to text' do
      expect(
        subject.(<<~AST)
          <Clause>
            <Subject>
              <Noun>eg</Noun>
              <Noun>berd</Noun>
            </Subject>
            <Predicate>
              <Verb>fol</Verb>
              <DirectObject>
                <Noun>mi</Noun>
              </DirectObject>
            </Predicate>
          </Clause>
        AST
      ).to eq("Eg Berd fol Mi")
    end
  end

  describe '.parse_xml' do
    subject { described_class.method(:parse_xml) }

    it 'parses AST syntax into an AST node tree' do
      expect(
        subject.(<<~AST)
          <Clause>
            <Subject>
              <Noun>dog</Noun>
            </Subject>
            <Predicate>
              <Verb>kil</Verb>
              <DirectObject>
                <Noun>bird</Noun>
              </DirectObject>
            </Predicate>
          </Clause>
        AST
      ).to eq(
        Astu::AST::Clause.new(
          subject: Astu::AST::NounPhrase.new(
            nouns: [Astu::AST::Noun.new(root: "dog")],
          ),
          predicate: Astu::AST::VerbPhrase.new(
            head: Astu::AST::Verb.new(root: "kil"),
            direct_object: Astu::AST::NounPhrase.new(
              nouns: [Astu::AST::Noun.new(root: "bird")],
            ),
          ),
        )
      )
    end
  end
end

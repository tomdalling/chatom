# frozen_string_literal: true

RSpec.describe Ashtu::AST, '#to_text' do
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
        Ashtu::AST::Clause.new(
          subject: Ashtu::AST::NounPhrase.new(
            head: Ashtu::AST::Noun.new(root: "dog"),
          ),
          predicate: Ashtu::AST::VerbPhrase.new(
            head: Ashtu::AST::Verb.new(root: "kil"),
            direct_object: Ashtu::AST::NounPhrase.new(
              head: Ashtu::AST::Noun.new(root: "bird"),
            ),
          ),
        )
      )
    end
  end
end

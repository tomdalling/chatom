# frozen_string_literal: true

RSpec.describe Astu::IPA do
  subject { described_class }

  it 'converts Astu text to IPA notation' do
    expect(subject.("dog kil berd")).to eq("dog kil bɛrd")
  end

  it 'maps e to ɛ and leaves other vowels unchanged' do
    expect(subject.("faia")).to eq("faia")
    expect(subject.("suim")).to eq("suim")
    expect(subject.("hed")).to eq("hɛd")
  end

  it 'maps all characters used in dictionary words without raising' do
    # covers every letter that appears in the non-TODO section of dictionary.txt
    all_chars = "abdefghiklmnoprstuz"
    expect { subject.(all_chars) }.not_to raise_error
  end
end

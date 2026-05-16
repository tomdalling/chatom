# frozen_string_literal: true

RSpec.describe Ashtu::IPA do
  subject { described_class }

  it 'converts Ashtu text to IPA notation' do
    expect(subject.("dog kil berd")).to eq("dog kil bɛrd")
  end
end

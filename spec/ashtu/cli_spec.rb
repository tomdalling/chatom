# frozen_string_literal: true

RSpec.describe Ashtu::CLI do
  describe "#run" do
    it "prints hello world" do
      expect { subject.run([]) }.to output("Hello, world!\n").to_stdout
    end
  end
end

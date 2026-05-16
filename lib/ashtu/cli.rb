# frozen_string_literal: true

module Ashtu
  class CLI
    def run(args = ARGV)
      options = parse_options(args)
      puts "Hello, world!"
    end

    private

    def parse_options(args)
      options = {}
      OptionParser.new do |parser|
        parser.banner = "Usage: ashtu [options]"
        parser.on("-h", "--help", "Print help") do
          puts parser
          exit
        end
      end.parse!(args)
      options
    end
  end
end

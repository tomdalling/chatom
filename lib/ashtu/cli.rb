# frozen_string_literal: true

module Ashtu
  class CLI
    def initialize(dictionary: Dictionary.new)
      @dictionary = dictionary
    end

    def run(args = ARGV)
      command, *rest = args
      case command
      when "lookup" then lookup(rest)
      when "search" then search(rest)
      else               help
      end
    end

    private

    def lookup(args)
      word = args.first
      if word.nil?
        puts "Usage: ashtu lookup <word>"
        return
      end
      if (entry = @dictionary.lookup(word))
        puts format_entry(entry)
      else
        puts "Word not found: #{word}"
      end
    end

    def search(args)
      query = args.first
      if query.nil?
        puts "Usage: ashtu search <term>"
        return
      end
      @dictionary.search(query).each { puts format_entry(_1) }
    end

    def format_entry(entry)
      "#{entry.word} [#{entry.part_of_speech}] #{entry.definition}"
    end

    def help
      puts <<~HELP
        Usage: ashtu <command> [args]

        Commands:
          lookup <word>   Look up an Ashtu word
          search <term>   Search for Ashtu words by English meaning
      HELP
    end
  end
end

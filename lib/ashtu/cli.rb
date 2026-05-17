# frozen_string_literal: true

module Ashtu
  class CLI
    def initialize(dictionary: Dictionary.new)
      @dictionary = dictionary
    end

    def run(args = ARGV)
      command, *rest = args
      case command
      when "lookup"           then lookup(rest)
      when "search"           then search(rest)
      when "list"             then list(rest)
      when "parse"            then parse_sentence(rest)
      when "-h", "--help"     then help
      else                         help
      end
    end

    private

    def lookup(args)
      if args.first.nil? || args.first == "-h" || args.first == "--help"
        puts "Usage: ashtu lookup <word>"
        puts "Look up an Ashtu word by exact match."
        return
      end
      if (entry = @dictionary.lookup(args.first))
        puts format_entry(entry)
      else
        puts "Word not found: #{args.first}"
      end
    end

    def search(args)
      if args.first.nil? || args.first == "-h" || args.first == "--help"
        puts "Usage: ashtu search <term>"
        puts "Search for Ashtu words by English meaning."
        return
      end
      @dictionary.search(args.first).each { puts format_entry(_1) }
    end

    def parse_sentence(args)
      if args.first.nil? || args.first == "-h" || args.first == "--help"
        puts "Usage: ashtu parse \"<sentence>\""
        puts "Parse an Ashtu sentence (subject verb object) into a structured representation."
        return
      end
      tokens = args.first.split
      Parser.parse(args.first, dictionary: @dictionary)
      s, v, o = tokens.map { @dictionary.lookup(_1) }
      puts "Clause:"
      puts "  Subject: #{s.word} (#{s.part_of_speech})"
      puts "  Predicate:"
      puts "    Verb: #{v.word} (#{v.part_of_speech})"
      puts "    DirectObject: #{o.word} (#{o.part_of_speech})"
    rescue ArgumentError => e
      puts "Error: #{e.message}"
    end

    def list(args)
      if args.first == "-h" || args.first == "--help"
        puts "Usage: ashtu list [--pos <part-of-speech>]"
        puts "List all dictionary entries, optionally filtered by part of speech."
        return
      end
      pos = args[args.index("--pos") + 1] if args.include?("--pos")
      @dictionary.list(pos: pos).each { puts format_entry(_1) }
    end

    def format_entry(entry)
      ipa = IPA.call(entry.word)
      "#{entry.word} [#{entry.part_of_speech}] /#{ipa}/ #{entry.definition}"
    rescue KeyError
      "#{entry.word} [#{entry.part_of_speech}] #{entry.definition}"
    end

    def help
      puts <<~HELP
        Usage: ashtu <command> [args]

        Commands:
          lookup <word>          Look up an Ashtu word
          search <term>          Search for Ashtu words by English meaning
          list [--pos <pos>]     List all dictionary entries
          parse "<sentence>"     Parse an Ashtu sentence (subject verb object)
      HELP
    end
  end
end

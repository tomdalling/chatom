# frozen_string_literal: true

module Astu
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
        puts "Usage: astu lookup <word>"
        puts "Look up an Astu word by exact match."
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
        puts "Usage: astu search <term>"
        puts "Search for Astu words by English meaning."
        return
      end
      @dictionary.search(args.first).each { puts format_entry(_1) }
    end

    def parse_sentence(args)
      if args.first.nil? || args.first == "-h" || args.first == "--help"
        puts "Usage: astu parse \"<sentence>\""
        puts "Parse an Astu sentence (subject verb [object]) into a structured representation."
        return
      end
      clause = Parser.parse(args.first, dictionary: @dictionary)
      puts clause.to_english_gloss(dictionary: @dictionary)
      puts Ox.dump(clause.to_xml_element, indent: 2, with_xml: false).strip
    rescue ArgumentError => e
      puts "Error: #{e.message}"
    end

    def list(args)
      if args.first == "-h" || args.first == "--help"
        puts "Usage: astu list [--pos <part-of-speech>]"
        puts "List all dictionary entries, optionally filtered by part of speech."
        return
      end
      pos = args[args.index("--pos") + 1] if args.include?("--pos")
      @dictionary.list(pos: pos).each { puts format_entry(_1) }
    end

    def format_entry(entry)
      pos = format_pos(entry)
      ipa = IPA.call(entry.word)
      first_line = "#{entry.word} [#{pos}] /#{ipa}/ #{entry.definition}"
      entry.description ? "#{first_line}\n  #{entry.description}" : first_line
    rescue KeyError
      first_line = "#{entry.word} [#{pos}] #{entry.definition}"
      entry.description ? "#{first_line}\n  #{entry.description}" : first_line
    end

    def format_pos(entry)
      suffix = case entry.transitivity
        when :transitive   then ":t"
        when :intransitive then ":i"
        when :both         then ":ti"
        else ""
      end
      "#{entry.part_of_speech}#{suffix}"
    end

    def help
      puts <<~HELP
        Usage: astu <command> [args]

        Commands:
          lookup <word>          Look up an Astu word
          search <term>          Search for Astu words by English meaning
          list [--pos <pos>]     List all dictionary entries
          parse "<sentence>"     Parse an Astu sentence (subject verb object)
      HELP
    end
  end
end

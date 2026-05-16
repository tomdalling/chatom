# frozen_string_literal: true

require "bundler/setup"

require "optparse"

require "value_semantics/monkey_patched"
require "ox"

require "zeitwerk"
Zeitwerk::Loader.new.tap do |loader|
  loader.push_dir(__dir__)
  loader.ignore(File.join(__dir__, "boot.rb"))
  loader.inflector.inflect(
    "cli" => "CLI",
    "ast_parser" => "ASTParser",
    "ast" => "AST",
    "ipa" => "IPA",
  )
  loader.setup
end

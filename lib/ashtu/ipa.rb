# frozen_string_literal: true

module Ashtu::IPA
  extend self

  def call(text)
    text.each_char.map { CHARACTER_LOOKUP.fetch(_1) }.join
  end

  private

    CHARACTER_LOOKUP = {
      " " => " ",
      "d" => "d",
      "g" => "g",
      "i" => "i",
      "k" => "k",
      "l" => "l",
      "o" => "o",
      "b" => "b",
      "e" => "ɛ",
      "r" => "r",
    }
end

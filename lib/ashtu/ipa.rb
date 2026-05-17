# frozen_string_literal: true

module Ashtu::IPA
  extend self

  def call(text)
    text.each_char.map { CHARACTER_LOOKUP.fetch(_1) }.join
  end

  private

    CHARACTER_LOOKUP = {
      " " => " ",
      "a" => "a",
      "b" => "b",
      "d" => "d",
      "e" => "ɛ",
      "f" => "f",
      "g" => "g",
      "h" => "h",
      "i" => "i",
      "k" => "k",
      "l" => "l",
      "m" => "m",
      "n" => "n",
      "o" => "o",
      "p" => "p",
      "r" => "r",
      "s" => "s",
      "t" => "t",
      "u" => "u",
      "v" => "v",
      "z" => "z",
    }
end

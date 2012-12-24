require "iso639/version"
require "iso639/insensitive_hash"

# Public: Various methods useful for performing ISO-639 language code lookup
# either given their ISO-639-1 or ISO-639-2 character code value or from human
# input.
#
# Examples
#
#   Iso639["en"]                          # => #<Iso639::Language:...>
#   Iso639["en"].alpha2                   # => "en"
#   Iso639["en"].alpha3                   # => "eng"
#   Iso639["en"].alpha3_bibliographic     # => "eng"
#   Iso639["en"].alpha3_terminology       # => nil
#   Iso639["en"].name                     # => "English"
#   Iso639["en"].english_name             # => "English"
#   Iso639["en"].french_name              # => "anglais"
#
#   Iso639["German"]                      # => #<Iso639::Language:...>
#   Iso639["German"].alpha2               # => "de"
#   Iso639["German"].alpha3               # => "ger"
#   Iso639["German"].alpha3_bibliographic # => "ger"
#   Iso639["German"].alpha3_terminology   # => "deu"
#   Iso639["German"].name                 # => "German"
#   Iso639["German"].english_name         # => "German"
#   Iso639["German"].french_name          # => "allemand"
module Iso639
  class Language
    attr_reader :alpha3_bibliographic, :alpha3_terminology, :alpha2, :english_name, :french_name
    alias_method :alpha3, :alpha3_bibliographic
    alias_method :name, :english_name

    # Public: Initialize a Language.
    #
    # alpha3_bibliographic - A String representing the alpha-3 bibliographic code
    # alpha3_terminology - A String representing the alpha-3 terminology code
    # alpha2 - A String representing the alpha-2 code
    # english_name - A String representing the English name
    # french_name - A String representing the French name
    def initialize(alpha3_bibliographic, alpha3_terminology, alpha2, english_name, french_name)
      @alpha3_bibliographic = strip_to_nil(alpha3_bibliographic)
      @alpha3_terminology   = strip_to_nil(alpha3_terminology)
      @alpha2               = strip_to_nil(alpha2)
      @english_name         = strip_to_nil(english_name)
      @french_name          = strip_to_nil(french_name)
    end

    private

    def strip_to_nil(val)
      val = val.strip if val
      return val unless val.nil? || val.empty?
    end
  end

  LanguagesByAlpha2 = InsensitiveHash.new
  LanguagesByAlpha3Bibliographic = LanguagesByAlpha3 = InsensitiveHash.new
  LanguagesByAlpha3Terminology = InsensitiveHash.new
  LanguagesByEnglishName = LanguagesByName = InsensitiveHash.new
  LanguagesByFrenchName = InsensitiveHash.new

  iso639_file = File.expand_path(File.join("..", "iso639", "ISO-639-2_utf-8.txt"), __FILE__)
  File.readlines(iso639_file, mode: "r:UTF-8").each do |line|
    lang = Language.new *line.split("|")
    LanguagesByAlpha2[lang.alpha2.downcase.strip]          = lang if lang.alpha2
    LanguagesByAlpha3[lang.alpha3.downcase.strip]          = lang if lang.alpha3
    LanguagesByAlpha3Terminology[lang.alpha3_terminology.downcase.strip] = lang if lang.alpha3_terminology
    LanguagesByName[lang.name.downcase.strip]              = lang if lang.name
    LanguagesByFrenchName[lang.french_name.downcase.strip] = lang if lang.french_name
  end

  def self.[](alpha_code_or_name)
    lookup = alpha_code_or_name.to_s.downcase.strip
    LanguagesByAlpha2[lookup] ||
      LanguagesByAlpha3Bibliographic[lookup] ||
      LanguagesByAlpha3Terminology[lookup] ||
      LanguagesByEnglishName[lookup] ||
      LanguagesByFrenchName[lookup]
  end
end

require "iso639/version"
require "iso639/language"
require "iso639/insensitive_hash"

# Public: Various methods useful for performing ISO-639 language code lookup
# either given their ISO-639-1 or ISO-639-2 character code value or from human
# input.
#
# Language code mappings came from
# http://loc.gov/standards/iso639-2/ISO-639-2_utf-8.txt
#
# Examples
#
#   Iso639["en"]                          # => "English"
#   Iso639["en"].alpha2                   # => "en"
#   Iso639["en"].alpha3                   # => "eng"
#   Iso639["en"].alpha3_bibliographic     # => "eng"
#   Iso639["en"].alpha3_terminology       # => "eng"
#   Iso639["en"].name                     # => "English"
#   Iso639["en"].english_name             # => "English"
#   Iso639["en"].french_name              # => "anglais"
#
#   Iso639["German"]                      # => "German"
#   Iso639["German"].alpha2               # => "de"
#   Iso639["German"].alpha3               # => "ger"
#   Iso639["German"].alpha3_bibliographic # => "ger"
#   Iso639["German"].alpha3_terminology   # => "deu"
#   Iso639["German"].name                 # => "German"
#   Iso639["German"].english_name         # => "German"
#   Iso639["German"].french_name          # => "allemand"
module Iso639
  LanguagesByAlpha2 = InsensitiveHash.new
  LanguagesByAlpha3Bibliographic = LanguagesByAlpha3 = InsensitiveHash.new
  LanguagesByAlpha3Terminology = InsensitiveHash.new
  LanguagesByEnglishName = LanguagesByName = InsensitiveHash.new
  LanguagesByFrenchName = InsensitiveHash.new

  iso639_file = File.expand_path(File.join("..", "iso639", "ISO-639-2_utf-8.txt"), __FILE__)
  File.readlines(iso639_file, encoding: "utf-8").each do |line|
    lang = Language.new(*line.split("|"))
    LanguagesByAlpha2[lang.alpha2]          = lang if lang.alpha2
    LanguagesByAlpha3[lang.alpha3]          = lang if lang.alpha3
    LanguagesByAlpha3Terminology[lang.alpha3_terminology] = lang if lang.alpha3_terminology
    lang.english_names.each { |name| LanguagesByName[name]       = lang }
    lang.french_names.each  { |name| LanguagesByFrenchName[name] = lang }
  end

  # Public: Find a language by any common lookup value
  #
  # lookup - A String representing an alpha-2, alpha-3, or language name
  #
  # Examples
  #
  #   Iso639["en"]               # => "English"
  #   Iso639["en"].alpha3        # => "eng"
  #   Iso639["English"].alpha2   # => "en"
  #   Iso639["FRENCH"].alpha3    # => "fre"
  #   Iso639["deu"].alpha3       # => "ger"
  #
  # Returns an Iso639::Language object
  def self.[](lookup)
    LanguagesByAlpha2[lookup] ||
      LanguagesByAlpha3Bibliographic[lookup] ||
      LanguagesByAlpha3Terminology[lookup] ||
      LanguagesByEnglishName[lookup] ||
      LanguagesByFrenchName[lookup]
  end
end

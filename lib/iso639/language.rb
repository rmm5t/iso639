module Iso639
  class Language
    attr_reader :alpha3_bibliographic, :alpha3_terminology, :alpha2, :english_names, :french_names
    alias_method :alpha3, :alpha3_bibliographic

    # Public: Initialize a Language.
    #
    # alpha3_bibliographic - A String representing the alpha-3 bibliographic code
    # alpha3_terminology - A String representing the alpha-3 terminology code
    # alpha2 - A String representing the alpha-2 code
    # english_names - A String representing the English names (semi-colon delimited)
    # french_names - A String representing the French names (semi-colon delimited)
    def initialize(alpha3_bibliographic, alpha3_terminology, alpha2, english_names, french_names)
      @alpha3_bibliographic = strip_to_nil(alpha3_bibliographic)
      @alpha3_terminology   = strip_to_nil(alpha3_terminology) || @alpha3_bibliographic
      @alpha2               = strip_to_nil(alpha2)
      @english_names        = split_and_strip(english_names)
      @french_names         = split_and_strip(french_names)
    end

    def english_name
      english_names.first
    end
    alias_method :name, :english_name
    alias_method :to_s, :english_name

    def french_name
      french_names.first
    end

    private

    def split_and_strip(names)
      names.split(/;\s*/).map { |n| strip_to_nil(n) }
    end

    def strip_to_nil(val)
      val = val.strip if val
      return val unless val.nil? || val.empty?
    end
  end
end

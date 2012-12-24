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
end

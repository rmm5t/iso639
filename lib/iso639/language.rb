module Iso639
  class Language
    attr_reader :alpha3_bibliographic, :alpha3_terminology, :alpha2, :english_names, :french_names
    alias_method :alpha3, :alpha3_bibliographic

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
      @english_names        = english_name.split(/;\s*/).map { |n| strip_to_nil(n) }
      @french_names         = french_name.split(/;\s*/).map { |n| strip_to_nil(n) }
    end

    def english_name
      english_names.first
    end
    alias_method :name, :english_name

    def french_name
      french_names.first
    end

    def to_s
      name
    end

    private

    def strip_to_nil(val)
      val = val.strip if val
      return val unless val.nil? || val.empty?
    end
  end
end

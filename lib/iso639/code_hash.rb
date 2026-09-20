require "iso639/insensitive_hash"

module Iso639
  class CodeHash < InsensitiveHash # :nodoc:
    private

    def normalize(key)
      super.split(/[-_]/).first
    end
  end
end

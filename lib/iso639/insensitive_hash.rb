module Iso639
  class InsensitiveHash < Hash # :nodoc:
    def [](key)
      super normalize(key)
    end

    def []=(key, value)
      super normalize(key), value
    end

    private

    def normalize(key)
      key.to_s.downcase.strip.split(/[-_]/).first
    end
  end
end

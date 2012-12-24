module Iso639
  class InsensitiveHash < Hash # :nodoc:
    def [](key)
      super(key.to_s.downcase.strip)
    end

    def []=(key, value)
      super(key.to_s.downcase.strip, value)
    end
  end
end

module Iso639
  class InsensitiveHash < Hash # :nodoc:
    def [](key)
      key.respond_to?(:downcase) ? super(key.downcase) : super(key)
    end

    def []=(key, value)
      key.respond_to?(:downcase) ? super(key.downcase, value) : super(key, value)
    end
  end
end

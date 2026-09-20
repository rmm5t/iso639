require "test_helper"

describe Iso639::CodeHash do
  it "should return results ignoring regional designators" do
    hash = Iso639::CodeHash.new
    hash["en_GB"] = "english"
    hash["fr_CA"] = "french"

    assert_equal "english", hash["en_US"]
    assert_equal "french",  hash["fr_FR"]
    assert_equal "english", hash["en-US"]
    assert_equal "french",  hash["fr-FR"]
    assert_equal "english", hash[" EN_us\t"]
  end
end

require "test_helper"

describe Iso639::InsensitiveHash do
  it "should return results ignoring case" do
    hash = Iso639::InsensitiveHash.new
    hash["foo"] = "one thing"
    hash["Bar"] = "another thing"
    hash["BAZ"] = "last thing"

    assert_equal "one thing",     hash["FOO"]
    assert_equal "another thing", hash["bar"]
    assert_equal "last thing",    hash["baz"]
  end

  it "should return results ignoring whitespace" do
    hash = Iso639::InsensitiveHash.new
    hash[" foo \t"] = "one thing"
    hash["Bar"] = "another thing"
    hash["\tBAZ\n"] = "last thing"

    assert_equal "one thing",     hash["FOO"]
    assert_equal "another thing", hash["  bar \t"]
    assert_equal "last thing",    hash["baz"]
  end

  it "should return results ignoring regional designators" do
    hash = Iso639::InsensitiveHash.new
    hash["en_GB"] = "english"
    hash["fr_CA"] = "french"

    assert_equal "english", hash["en_US"]
    assert_equal "french",  hash["fr_FR"]
    assert_equal "english", hash["en-US"]
    assert_equal "french",  hash["fr-FR"]
  end
end

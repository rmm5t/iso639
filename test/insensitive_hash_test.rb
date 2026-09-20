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

  it "should preserve hyphens and underscores in keys" do
    hash = Iso639::InsensitiveHash.new
    hash["Judeo-Persian"] = "jpr"
    hash["Judeo-Arabic"] = "jrb"
    hash["Judeo_Persian"] = "underscore"

    assert_equal "jpr",        hash[" JUDEO-PERSIAN "]
    assert_equal "jrb",        hash["judeo-arabic"]
    assert_equal "underscore", hash["judeo_persian"]
    assert_nil hash["Judeo"]
    assert_nil hash["Judeo-Unknown"]
  end
end

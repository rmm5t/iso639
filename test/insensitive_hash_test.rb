require "test_helper"

describe Iso639::InsensitiveHash do
  it "should returns results ignore case" do
    hash = Iso639::InsensitiveHash.new
    hash["foo"] = "one thing"
    hash["Bar"] = "another thing"
    hash["BAZ"] = "last thing"

    assert_equal "one thing",     hash["FOO"]
    assert_equal "another thing", hash["bar"]
    assert_equal "last thing",    hash["baz"]
  end
end

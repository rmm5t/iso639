require "test_helper"

describe Iso639::InsensitiveHash do
  it "should returns results ignore case" do
    hash = Iso639::InsensitiveHash.new
    hash["foo"] = "one thing"
    hash["Bar"] = "another thing"
    hash["BAZ"] = "last thing"

    assert_equal hash["foo"], hash["FOO"]
    assert_equal hash["BAR"], hash["bar"]
    assert_equal hash["Baz"], hash["baz"]
  end
end

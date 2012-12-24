# -*- coding: utf-8 -*-
require "test_helper"

describe Iso639::Language do
  it "should respond to char codes and names" do
    lang = Iso639::Language.new "eng", "", "en", "English", "anglais"
    assert lang.respond_to? :alpha3_bibliographic
    assert lang.respond_to? :alpha3_terminology
    assert lang.respond_to? :alpha3
    assert lang.respond_to? :alpha2
    assert lang.respond_to? :english_name
    assert lang.respond_to? :french_name
    assert lang.respond_to? :name
  end

  it "should assign the proper accessor from the constructor" do
    lang = Iso639::Language.new "fre", "fra", "fr", "French", "français"
    assert "fre",      lang.alpha3_bibliographic
    assert "fre",      lang.alpha3
    assert "fra",      lang.alpha3_terminology
    assert "fr",       lang.alpha2
    assert "French",   lang.english_name
    assert "French",   lang.name
    assert "français", lang.french_name
  end

  it "should resolve blank values to nil" do
    lang = Iso639::Language.new "", "", "", "", ""
    assert_nil lang.alpha3_bibliographic
    assert_nil lang.alpha3_terminology
    assert_nil lang.alpha2
    assert_nil lang.english_name
    assert_nil lang.french_name
  end

  it "should not be mutable" do
    lang = Iso639::Language.new("eng", nil, "en", "English", "anglais").freeze
    begin
      lang.name = "British English"
      lang.alpha2 = "br"
      assert false
    rescue NoMethodError
      assert true
    end
  end
end

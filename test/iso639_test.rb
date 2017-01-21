# -*- coding: utf-8 -*-
require "test_helper"

describe Iso639::LanguagesByAlpha2 do
  it "should return valid languages by alpha-2 code" do
    assert_equal "en",     Iso639::LanguagesByAlpha2["EN"].alpha2
    assert_equal "fre",    Iso639::LanguagesByAlpha2["fr"].alpha3
    assert_equal "German", Iso639::LanguagesByAlpha2["de"].name
  end

  it "should return nil for unknown codes" do
    assert_nil Iso639::LanguagesByAlpha2["xx"]
    assert_nil Iso639::LanguagesByAlpha2["eng"]
    assert_nil Iso639::LanguagesByAlpha2["English"]
  end
end

describe Iso639::LanguagesByAlpha3Bibliographic do
  it "should return valid languages by alpha-3 bibliographic code" do
    assert_equal "en",     Iso639::LanguagesByAlpha3Bibliographic["ENG"].alpha2
    assert_equal "en",     Iso639::LanguagesByAlpha3["eng"].alpha2
    assert_equal "fre",    Iso639::LanguagesByAlpha3["fre"].alpha3
    assert_equal "German", Iso639::LanguagesByAlpha3["ger"].name
  end

  it "should return nil for unknown codes" do
    assert_nil Iso639::LanguagesByAlpha3["xxx"]
    assert_nil Iso639::LanguagesByAlpha3["en"]
    assert_nil Iso639::LanguagesByAlpha3["English"]
  end
end

describe Iso639::LanguagesByAlpha3Terminology do
  it "should return valid languages by alpha-3 terminology code" do
    assert_equal "fre",    Iso639::LanguagesByAlpha3Terminology["fra"].alpha3
    assert_equal "German", Iso639::LanguagesByAlpha3Terminology["DEU"].name
  end

  it "should return valid languages by alpha-3 terminology code when it matches the bibliographic" do
    assert_equal "English", Iso639::LanguagesByAlpha3Terminology["eng"].name
  end

  it "should return nil for unknown codes" do
    assert_nil Iso639::LanguagesByAlpha3Terminology["xxx"]
    assert_nil Iso639::LanguagesByAlpha3Terminology["en"]
    assert_nil Iso639::LanguagesByAlpha3Terminology["English"]
  end
end

describe Iso639::LanguagesByEnglishName do
  it "should return valid languages by name" do
    assert_equal "en",      Iso639::LanguagesByName["ENGLISH"].alpha2
    assert_equal "fre",     Iso639::LanguagesByName["French"].alpha3
    assert_equal "German",  Iso639::LanguagesByName["German"].name
    assert_equal "German",  Iso639::LanguagesByName["german"].name
    assert_equal "spa",     Iso639::LanguagesByName["spanish"].alpha3
    assert_equal "klingon", Iso639::LanguagesByName["Klingon"].french_name
    assert_equal "Klingon", Iso639::LanguagesByName["tlhIngan-Hol"].name
  end

  it "should return nil for unknown codes" do
    assert_nil Iso639::LanguagesByName["xxxxxx"]
    assert_nil Iso639::LanguagesByName["en"]
    assert_nil Iso639::LanguagesByName["eng"]
  end
end

describe Iso639::LanguagesByFrenchName do
  it "should return valid languages by name" do
    assert_equal "fre",    Iso639::LanguagesByFrenchName["français"].alpha3
    assert_equal "German", Iso639::LanguagesByFrenchName["allemand"].name
  end

  it "should return nil for unknown codes" do
    assert_nil Iso639::LanguagesByFrenchName["xxxxxx"]
    assert_nil Iso639::LanguagesByFrenchName["an"]
    assert_nil Iso639::LanguagesByFrenchName["English"]
  end
end

describe Iso639 do
  it "should return valid langauge by alpha-2, alpha-3, or name" do
    assert_equal "en", Iso639["en"].alpha2
    assert_equal "en", Iso639["EN"].alpha2
    assert_equal "fr", Iso639["fre"].alpha2
    assert_equal "fr", Iso639["fra"].alpha2
    assert_equal "fr", Iso639["French"].alpha2
    assert_equal "fr", Iso639["français"].alpha2
    assert_equal "krc", Iso639["Karachay-Balkar"].alpha3
  end

  it "should ignore case sensitivity" do
    assert_equal "en", Iso639["EN"].alpha2
    assert_equal "fr", Iso639["Fre"].alpha2
    assert_equal "fr", Iso639["FRA"].alpha2
    assert_equal "fr", Iso639["french"].alpha2
  end

  it "should ignore whitespace" do
    assert_equal "en", Iso639[" en"].alpha2
    assert_equal "fr", Iso639["\tfre\t"].alpha2
    assert_equal "fr", Iso639["   fra   "].alpha2
    assert_equal "fr", Iso639[" french\t"].alpha2
  end

  it "should ignore regional designations" do
    assert_equal "en", Iso639["en_US"].alpha2
    assert_equal "en", Iso639["en_GB"].alpha2
    assert_equal "fr", Iso639["fr-CA"].alpha2
    assert_equal "fr", Iso639["fr-FR"].alpha2
  end
end

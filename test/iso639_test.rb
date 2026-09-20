# -*- coding: utf-8 -*-
require "test_helper"

describe Iso639::LanguagesByAlpha2 do
  it "should return valid languages by alpha-2 code" do
    assert_equal "en",     Iso639::LanguagesByAlpha2["EN"].alpha2
    assert_equal "fre",    Iso639::LanguagesByAlpha2["fr"].alpha3
    assert_equal "German", Iso639::LanguagesByAlpha2["de"].name
  end

  it "should ignore regional designations" do
    assert_equal "en", Iso639::LanguagesByAlpha2["en_US"].alpha2
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

  it "should ignore regional designations" do
    assert_equal "fre", Iso639::LanguagesByAlpha3Bibliographic["fre-CA"].alpha3
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

  it "should ignore regional designations" do
    assert_equal "fre", Iso639::LanguagesByAlpha3Terminology["fra_CA"].alpha3
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

  it "should resolve every English name to its language" do
    Iso639::LanguagesByAlpha3.each_value do |lang|
      lang.english_names.each do |name|
        assert_same lang, Iso639::LanguagesByEnglishName[name],
          "Expected #{name.inspect} to resolve to #{lang.alpha3}"
      end
    end
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

  it "should resolve every French name to its language" do
    Iso639::LanguagesByAlpha3.each_value do |lang|
      lang.french_names.each do |name|
        assert_same lang, Iso639::LanguagesByFrenchName[name],
          "Expected #{name.inspect} to resolve to #{lang.alpha3}"
      end
    end
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

  it "should resolve Afar by its alpha-3 code without a byte order mark" do
    assert_equal "aar", Iso639["aa"].alpha3
    assert_same Iso639["aa"], Iso639["aar"]
    assert_same Iso639["aa"], Iso639::LanguagesByAlpha3Terminology["aar"]
  end

  it "should resolve Montenegrin by code and name" do
    lang = Iso639["cnr"]
    refute_nil lang
    assert_equal "Montenegrin", lang.name
    assert_equal "monténégrin", lang.french_name
    assert_nil lang.alpha2
    assert_same lang, Iso639["Montenegrin"]
    assert_same lang, Iso639["monténégrin"]
  end

  it "should resolve updated language names and aliases" do
    assert_equal "Tlicho", Iso639["dgr"].name
    assert_equal "dgr", Iso639["Tlicho"].alpha3
    assert_equal "dgr", Iso639["Dogrib"].alpha3
    assert_equal "Modern Greek (1453-)", Iso639["ell"].name
    assert_equal "gre", Iso639["Modern Greek (1453-)"].alpha3
    assert_equal "Wolaitta", Iso639["wal"].name
    assert_equal "wal", Iso639["Wolaitta"].alpha3
    assert_equal "wal", Iso639["Wolaytta"].alpha3
    assert_equal "new", Iso639["Newar"].alpha3
    assert_equal "new", Iso639["néwar"].alpha3
    assert_equal "pro", Iso639["Occitan, Old (to 1500)"].alpha3
  end

  it "should retain Bihari languages without the removed alpha-2 code" do
    assert_equal "Bihari languages", Iso639["bih"].name
    assert_nil Iso639["bih"].alpha2
    assert_nil Iso639["bh"]
    assert_nil Iso639::LanguagesByAlpha2["bh"]
  end

  it "should return nil for names removed from the snapshot" do
    assert_nil Iso639["Walamo"]
    assert_nil Iso639["Provençal"]
  end

  it "should distinguish hyphenated language names" do
    assert_equal "jpr", Iso639["Judeo-Persian"].alpha3
    assert_equal "jrb", Iso639["Judeo-Arabic"].alpha3
    assert_equal "lua", Iso639["Luba-Lulua"].alpha3
    assert_equal "lub", Iso639["Luba-Katanga"].alpha3
    assert_equal "jpr", Iso639[" JUDÉO-PERSAN\t"].alpha3
    assert_equal "jrb", Iso639["judéo-arabe"].alpha3
    assert_equal "lad", Iso639["judéo-espagnol"].alpha3
    assert_equal "lua", Iso639["luba-lulua"].alpha3
    assert_equal "inc", Iso639["indo-aryennes, langues"].alpha3
    assert_equal "ine", Iso639["indo-européennes, langues"].alpha3
  end

  it "should prefer complete language names to locale prefixes" do
    assert_equal "mkh", Iso639["Mon-Khmer languages"].alpha3
    assert_equal "dsb", Iso639["bas-sorabe"].alpha3
  end

  it "should prefer exact codes to matching language names" do
    assert_equal "gle", Iso639["Ga"].alpha3
    assert_equal "gaa", Iso639::LanguagesByName["Ga"].alpha3
  end

  it "should return nil for incomplete or unknown hyphenated names" do
    assert_nil Iso639["Judeo"]
    assert_nil Iso639["Judeo-Unknown"]
    assert_nil Iso639["Karachay"]
    assert_nil Iso639["Karachay-Unknown"]
    assert_nil Iso639["English-Unknown"]
    assert_nil Iso639["English_Unknown"]
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
    assert_equal "en", Iso639[" ENG_us\t"].alpha2
    assert_equal "fr", Iso639["fre-CA"].alpha2
    assert_equal "fr", Iso639["fra_CA"].alpha2
    assert_equal "zh", Iso639["zh-Hant-TW"].alpha2
  end
end

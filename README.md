# iso639 [![Gem Version](https://badge.fury.io/rb/iso639.png)](http://badge.fury.io/rb/iso639) [![Build Status](https://travis-ci.org/rmm5t/iso639.png?branch=master)](https://travis-ci.org/rmm5t/iso639) [![Coverage Status](https://coveralls.io/repos/rmm5t/iso639/badge.png?branch=master)](https://coveralls.io/r/rmm5t/iso639)

The iso639 gem provides convenience methods for looking up ISO-639-1 or
ISO-639-2 language codes by their english name, 2-char, or 3-char counterpart

## Installation

Add this line to your application's Gemfile:

```ruby
gem "iso639"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install iso639
```

## Usage

```ruby
require "iso639"

# Lookup by alpha-2 codes
Iso639["en"]                          # => "English"
Iso639["en"].alpha2                   # => "en"
Iso639["en"].alpha3                   # => "eng"
Iso639["en"].alpha3_bibliographic     # => "eng"
Iso639["en"].alpha3_terminology       # => "eng"
Iso639["en"].name                     # => "English"
Iso639["en"].english_name             # => "English"
Iso639["en"].french_name              # => "anglais"

# Lookup by alpha-3-bibliographic codes
Iso639["fre"]                         # => "French"
Iso639["fre"].alpha2                  # => "fr"
Iso639["fre"].alpha3                  # => "fre"
Iso639["fre"].alpha3_bibliographic    # => "fre"
Iso639["fre"].alpha3_terminology      # => "fra"
Iso639["fre"].name                    # => "French"
Iso639["fre"].english_name            # => "French"
Iso639["fre"].french_name             # => "français"

# Lookup by alpha-3-terminology codes
Iso639["fra"]                         # => "French"
Iso639["fra"].alpha2                  # => "fr"
Iso639["fra"].alpha3                  # => "fre"
Iso639["fra"].alpha3_bibliographic    # => "fre"
Iso639["fra"].alpha3_terminology      # => "fra"
Iso639["fra"].name                    # => "French"
Iso639["fra"].english_name            # => "French"
Iso639["fra"].french_name             # => "français"

# Lookup by name
Iso639["German"]                      # => "German"
Iso639["German"].alpha2               # => "de"
Iso639["German"].alpha3               # => "ger"
Iso639["German"].alpha3_bibliographic # => "ger"
Iso639["German"].alpha3_terminology   # => "deu"
Iso639["German"].name                 # => "German"
Iso639["German"].english_name         # => "German"
Iso639["German"].french_name          # => "allemand"

# Retrieve alpha-2 codes
Iso639["English"].alpha2              # => "en"
Iso639["fre"].alpha2                  # => "fr"
Iso639["deu"].alpha2                  # => "de"
Iso639["pl"].alpha2                   # => "pl"

# Retrieve alpha-3 codes
Iso639["english"].alpha3              # => "eng"
Iso639["fr"].alpha3                   # => "fre"
Iso639["ger"].alpha3                  # => "ger"

# Retrieve names
Iso639["eng"].name                    # => "English"
Iso639["fr"].name                     # => "French"
Iso639["de"].name                     # => "German"
Iso639["deu"].name                    # => "German"
Iso639["ger"].name                    # => "German"
Iso639["german"].name                 # => "German"
Iso639["GeRmAn"].name                 # => "German"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Build Status](https://travis-ci.org/tabfugnic/rakemkv.png)](https://travis-ci.org/tabfugnic/rakemkv)

# Rakemkv

A fully object oriented wrapper around MakeMKV to help facilitate more
programmable backups.

## Requirements

- MakeMKV

## Installation

Add this line to your application's Gemfile:

    gem 'rakemkv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rakemkv

## Usage

disc = RakeMKV::Disc.new("location/to/disc")
disc.transcode!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

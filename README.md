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

Most straight forward usage to transcode a single disc. This will find
the longest title, transcode it, and place that file in the working
directory.

```
disc = RakeMKV::Disc.new(location: "path/to/disc")
disc.transcode!
```

`transcode!` by default will transcode the longest title, but it takes
`title_id` as an argument if you determine a different title. Passing
`all` will include every title above the minimum length specified.

To transcode the fifth title you would do:

```
disc = RakeMKV::Disc.new(location: "path/to/disc")
disc.transcode!(title_id: 5)
```

`Disc` takes destination and minlength as arguments as well. This lets
you determine where you want the files to end up and what the minimum
length of the titles transcoded must be.

For example, if you wanted to transcode titles over the 20 minutes
long into the tmp directory you can do the following:

```
disc = RakeMKV::Disc.new(
  destination: "/tmp",
  location: "path/to/disc",
  minlength: 1200, # time in seconds
)
disc.transcode!(title_id: "all")
```

## Configuration

You can configure RakeMKV by doing the following:

```ruby
RakeMKV.configure do |config|
  config.binary = "new_makemkv_binary'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

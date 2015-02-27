module RakeMKV
  def self.binary
    "makemkvcon"
  end

  def self.transcode(path)
    Disc.new(path).transcode!
  end
end

require "cocaine"
require "rakemkv/disc"
require "rakemkv/title"
require "rakemkv/titles"
require "rakemkv/command"
require "rakemkv/parser"
require "rakemkv/code"

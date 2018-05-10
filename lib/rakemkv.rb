module RakeMKV
  def self.config
    Configuration.instance
  end

  def self.configure
    yield config
  end
end

require "terrapin"
require "singleton"
require "rakemkv/binary"
require "rakemkv/code"
require "rakemkv/command"
require "rakemkv/configuration"
require "rakemkv/disc"
require "rakemkv/parser"
require "rakemkv/title"
require "rakemkv/titles"

module RakeMKV
  def self.binary
    'makemkvcon'
  end
end

require 'cocaine'
require 'rakemkv/disc'
require 'rakemkv/title'
require 'rakemkv/titles'
require 'rakemkv/command'
require 'rakemkv/parser'
require 'rakemkv/code'

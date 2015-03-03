class RakeMKV::Configuration
  include Singleton

  attr_accessor :minimum_title_length
  attr_writer :binary

  def binary
    @binary || 'makemkvcon'
  end

  def reset!
    self.minimum_title_length = nil
    self.binary = nil
  end
end

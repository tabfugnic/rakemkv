class RakeMKV::Configuration
  include Singleton

  attr_accessor :minimum_title_length
  attr_writer :binary, :destination

  def binary
    @binary || 'makemkvcon'
  end

  def destination
    @destination || Dir.pwd
  end

  def reset!
    self.binary = nil
    self.destination = nil
    self.minimum_title_length = nil
  end
end

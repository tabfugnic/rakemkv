class RakeMKV::Configuration
  include Singleton

  attr_accessor :minimum_title_length
  attr_writer :binary, :destination

  def binary
    @binary || "makemkvcon"
  end

  def reset!
    self.binary = nil
  end
end

class RakeMKV::Video
  attr_reader :path

  def initialize(path:)
    @path = path
  end
end

#  Disc object
class RakeMKV::Disc
  attr_reader :location

  #  Initialize disc
  def initialize(location)
    @location = location
  end

  #  Find available discs and content
  def self.discs
    RakeMKV::Command.new('disc:9999').info
  end

  # Get path from location
  def path
    case
    when location =~ /^\/dev/
      "dev:#{location}"
    when location =~ /iso$/
      "iso:#{location}"
    when location.is_a?(Integer)
      "disc:#{location}"
    when location =~ /^disc/
      location
    else
      raise RuntimeError
    end
  end

  # parse file info from command
  def info
    @info ||= RakeMKV::Parser.new(command.info)
  end

  #  Transcode information on disc
  def transcode!(destination = '.', options = {})
    check!(destination)
    title_id = options[:title_id] || titles.longest.id
    command.mkv(title_id, destination)
  end

  # Get titles for disc
  def titles
    @titles ||= info.tinfo.each_with_index.map do |title, title_id|
      RakeMKV::Title.new(title_id, title)
    end
    RakeMKV::Titles.new(@titles)
  end

  #  Meta disc information
  def method_missing(method, *args)
    info.cinfo[method.to_sym] || super
  end

  private

  def check!(destination)
    raise StandardError unless File.directory? destination
  end

  def command
    RakeMKV::Command.new(path)
  end
end

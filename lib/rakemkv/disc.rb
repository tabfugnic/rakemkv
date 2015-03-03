#  Disc object
class RakeMKV::Disc
  attr_reader :location

  #  Initialize disc
  def initialize(location)
    @location = location
  end

  # Get path from location
  def path
    if location =~ /^\/dev/
      "dev:#{location}"
    elsif location =~ /iso$/
      "iso:#{location}"
    elsif location.is_a?(Integer)
      "disc:#{location}"
    elsif location =~ /^disc/
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
    RakeMKV::Titles.new(build_titles)
  end

  #  Meta disc information
  def method_missing(method, *args)
    info.cinfo[method.to_sym] || super
  end

  private

  def command
    RakeMKV::Command.new(path)
  end

  def build_titles
    info.tinfo.each_with_index.map do |title, title_id|
      RakeMKV::Title.new(title_id, title)
    end
  end

  def check_directory!(destination)
    unless File.directory? destination
      raise StandardError
    end
  end
end

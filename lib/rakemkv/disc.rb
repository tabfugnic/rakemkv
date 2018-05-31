#  Disc object
class RakeMKV::Disc
  attr_reader :location

  #  Initialize disc
  def initialize(
    location:,
    destination: Dir.pwd,
    minlength: RakeMKV.config.minimum_title_length
  )
    @location = location
    @destination = destination
    @minlength = minlength
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
    @info ||= RakeMKV::Parser.new command.info(arguments)
  end

  #  Transcode information on disc
  def transcode!(title_id: titles.longest.id)
    Dir.mkdir(destination_with_name)
    command.mkv(title_id, destination_with_name, arguments)
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

  attr_reader :minlength, :destination

  def command
    RakeMKV::Command.new(path: path)
  end

  def destination_with_name
    File.join(destination, name)
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

  def arguments
    { minlength: minlength }.compact
  end
end

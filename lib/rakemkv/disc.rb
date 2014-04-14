#  Disc object
class RakeMKV::Disc
  attr_reader :path, :info, :command, :titles

  #  Initialize disc
  def initialize(location)
    @path = determine_path(location)
    @command = RakeMKV::Command.new(@path)
    @info = RakeMKV::Parser.new(@command.info)
    @titles = RakeMKV::Titles.new(info.tinfo)
  end

  #  Find available discs and content
  def self.discs
    RakeMKV::Command.new('disc:9999').info
  end

  #  Transcode information on disc
  def transcode!(destination, options = {})
    check!(destination)
    if options[:title_id]
      command.mkv(options[:title_id], destination)
    else
      command.mkv(titles.longest.id, destination)
    end
  end

  #  Meta disc information
  def method_missing(method, *args)
    info.cinfo[method.to_sym] || super
  end

  private

  def check!(destination)
    fail StandardError unless File.directory? destination
  end

  def determine_path(location)
    return "dev:#{location}" if location =~ /^\/dev/
    return "iso:#{location}" if location =~ /iso$/
    return "disc:#{location}" if location.is_a? Integer
    return location if location =~ /^disc/
    fail RuntimeError
  end
end

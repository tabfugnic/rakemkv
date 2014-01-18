module RakeMKV
  ##
  #  Disc object
  #
  class Disc
    attr_reader :path, :raw_info, :info, :command
    attr_writer :titles, :format

    ##
    #  Initialize disc
    #
    def initialize(location)
      @path = determine_path(location)
      @titles = Array.new
      @command = Command.new(@path)
      @info = RakeMKV::Parser.new(@command.info)
    end

    ##
    #  Find available discs and content
    #
    def self.discs
      Command.new('disc:9999').info
    end

    ##
    #  Transcode information on disc
    #
    def transcode!(destination, sel_title=nil, time=1200)
      destination = check(destination)
      titles.each do |title|
        next if sel_title && sel_title != title.id
        command.mkv(title.id, destination) if title.time > time
      end
    end

    ##
    #  get disc type information
    #
    def type
      info.cinfo[:type]
    end

    ##
    #  Get name of the disc
    #
    def name
      info.cinfo[:name]
    end

    ##
    #  Get longest title
    #
    def longest
      titles.max { |a,b| a.time <=> b.time }
    end

    ##
    #  Get title information on disc
    #
    def titles
      return @titles unless @titles.empty?
      info.tinfo.each_with_index do |title, title_id|
        @titles << Title.new(title_id, title)
      end
      return @titles
    end

    ##
    #  Check for shorter lengthed video
    #
    def short?
      titles.select { |t| t.short_length? }.length >= 3
    end

    private

    def check(destination)
      raise StandardError unless File.directory? destination
      return destination
    end

    def determine_path(location)
      return "dev:#{location}" if location =~ /^\/dev/
      return "iso:#{location}" if location =~ /iso$/
      return "disc:#{location}" if location.is_a? Integer
      return location if location =~ /^disc/
      raise RuntimeError
    end
  end
end

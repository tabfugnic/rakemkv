module RakeMKV
  ##
  #  Disc object
  #
  class Disc
    attr_reader :path
    attr_writer :titles
    attr_accessor :destination

    ##
    #  Initialize disc
    #
    def initialize(location)
      @path = determine_path(location)
      @titles = Array.new
    end

    ##
    #  Find available drives and content
    #
    def self.drives
      `makemkvcon -r info disc:9999`
    end

    ##
    #  get information on disc
    #
    def info
      @info ||= `#{mkvcon} info #{path}`
    end

    ##
    #  Transcode information on disc
    #
    def transcode!(destination, sel_title=nil, time=1200)
      titles.each do |title|
        break if sel_title && sel_title != title.num
        `#{mkvcon} mkv #{path} #{title.num} #{check(destination)}` if title.time > time
      end
    end

    ##
    #  Get title information on disc
    #
    def titles
      return @titles unless @titles.empty?
      cleanup(info).each do |line|
        @titles << Title.new(line[-3], line[-1], line[-2], line[0]) if line[0] == "MSG:3028"
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

    def mkvcon
      return "makemkvcon -r" # Always robot mode all the time.
    end

    def cleanup(info) # Better way to do this?  Maybe
      info.split("\n").each.map do |line|
        line.split(",").each.map do |element|
          element.strip.gsub(/\"/, "")
        end
      end
    end

    def check(destination)
      raise StandardError unless File.directory? destination
      return destination
    end

    def determine_path(location)
      case location
      when /dev/
        "dev:#{location.gsub('/dev/', '')}"
      when /iso/
        "iso:#{location}"
      when /disc:/
        location
      else
        raise TypeError
      end
    end
  end
end

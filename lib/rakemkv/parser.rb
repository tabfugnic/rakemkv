##
# Parser
#
class RakeMKV::Parser
  CINFO_REGEX = /CINFO:(\d+),\d+,"(.+)"/
  DRIVES_REGEX = /DRV:\d+,\d+,\d+,(\d+),"(.*)","(.*)","(.*)"/
  MSG_REGEX = /MSG:[^"]*"([^"]*)"/
  SINFO_REGEX = /SINFO:(\d+),(\d+),(\d+),\d+,"(.*)"/
  TINFO_REGEX = /TINFO:(\d+),(\d+),\d+,"(.*)"/

  attr_reader :raw

  ##
  #  Initialize using info received from disc
  #
  def initialize(raw_info)
    @raw = raw_info
  end

  ##
  #  Grab information from cinfo
  #
  def cinfo
    @cinfo = {}
    parse(CINFO_REGEX) do |code, info|
      code = RakeMKV::Code[code]
      @cinfo[code] = info
    end
    @cinfo
  end

  ##
  #  Grab information from tinfo
  #
  def tinfo
    @tinfo = []
    parse(TINFO_REGEX) do |title_id, code, info|
      code = RakeMKV::Code[code]
      @tinfo[title_id.to_i] ||= Hash.new
      @tinfo[title_id.to_i][code] = info
    end
    @tinfo
  end

  ##
  #  Grab information from sinfo
  #
  def sinfo
    @sinfo = []
    parse(SINFO_REGEX) do |title_id, section_id, code, info|
      code = RakeMKV::Code[code]
      title = title_id.to_i
      specific = section_id.to_i
      @sinfo[title] ||= Array.new
      @sinfo[title][specific] ||= Hash.new
      @sinfo[title][specific][code] = info
    end
    @sinfo
  end

  ##
  #  Grab information from messages
  #
  def messages
    @messages = Array.new
    parse(MSG_REGEX) do |info|
      @messages << info.first
    end
    @messages
  end

  ##
  #  Grab information from discs
  #
  def drives
    @drives = Array.new
    parse(DRIVES_REGEX) do |accessible, drive_name, disc_name, location|
      drive = { accessible: accessible(accessible),
                drive_name: drive_name,
                disc_name: disc_name,
                location: location }
      @drives << drive
    end
    @drives
  end

  private

  def accessible(accessible)
    accessible != '0'
  end

  def parse(regex, &block)
    raw.split('\n').each do |line|
      line.scan(regex, &block)
    end
  end
end

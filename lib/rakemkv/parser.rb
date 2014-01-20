module RakeMKV
  ##
  # Parser
  #
  class Parser
    attr_reader :raw

    def initialize(raw_info)
      @raw = raw_info
    end

    def cinfo
      @cinfo = {}
      guide('CINFO') do |line|
        code = RakeMKV::Code[line[0]]
        @cinfo[code] = line[2]
      end
      @cinfo
    end

    def tinfo
      @tinfo = []
      guide('TINFO') do |line|
        code = RakeMKV::Code[line[1]]
        title = line[0].to_i
        @tinfo[title] = Hash.new unless @tinfo[title].is_a? Hash
        @tinfo[title][code] = line[3]
      end
      @tinfo
    end

    def sinfo
      @sinfo = []
      guide('SINFO') do |line|
        code = RakeMKV::Code[line[2]]
        title = line[0].to_i
        specific = line[1].to_i
        @sinfo[title] = Array.new unless @sinfo[title].is_a? Array
        @sinfo[title][specific] = {} unless @sinfo[title][specific].is_a? Hash
        @sinfo[title][specific][code] = line[4]
      end
      @sinfo
    end

    def messages
      @messages = cleaned.map do |line|
        split = line[0].split(':')
        line[3] if split.first == 'MSG'
      end
      @messages.compact!
      @messages
    end

    def drives
      @drives = cleaned.map do |line|
        if line[0].split(':').first == 'DRV'
          { accessible: accessible(line),
            drive_name: line[4],
            disc_name: line[5] }
        end
      end
      @drives.compact!
      @drives
    end

    private

    def guide(content, &block)
      cleaned.each do |line|
        split = line[0].split(':')
        line[0] = split.last
        yield(line) if split.first == content
      end
    end

    def accessible(line)
      line[1].to_i > 0
    end

    def cleaned # Better way to do this?  Maybe
      raw.split("\n").each.map do |line|
        line.split(',').each.map do |element|
          element.strip.gsub(/\"/, '')
        end
      end
    end
  end
end

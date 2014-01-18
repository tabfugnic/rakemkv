module RakeMKV
  class Title

    attr_reader :time, :id, :code, :chapter_count, :size

    MINUTE = 60
    HOUR = 3600

    ##
    # Constructor for title
    #
    def initialize(id, options)
      # These claim to start at 1, but the CLI treats them as starting from 0
      @id = id
      @time =  convert_to_sec(options[:duration])
      @chapter_count = options[:chapter_count].to_i
      @size = options[:disk_size_bytes].to_i
    end

    ##
    # Find short lengthed title
    #
    def short_length?
      return time > 900 && time < 2100
    end

    private

    ##
    # Convert string of time in format HH:MM:SEC
    # to integer representing time in seconds
    #
    def convert_to_sec(time)
      return time if time.is_a? Integer
      times = time.split(':')
      return (times[0].to_i * HOUR) + (times[1].to_i * MINUTE) + (times[2].to_i)
    end
  end
end

module RakeMKV
  class Title

    attr_accessor :id, :cells
    attr_reader :time

    MINUTE = 60
    HOUR = 3600

    ##
    # Constructor for title
    #
    def initialize(id, time, cells, code=nil)
      @id = id.to_i
      @time =  convert_to_sec(time)
      @cells = cells.to_i
      @code = code
    end

    ##
    # Setter for time, converting string to seconds
    #
    def time=(time)
      @time = convert_to_sec(time)
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
      times = time.split(":")
      return (times[0].to_i * HOUR) + (times[1].to_i * MINUTE) + (times[2].to_i)
    end
  end
end

module RakeMKV
  class Title

    attr_accessor :id, :cells
    attr_reader :time

    def initialize(id, time, cells, code=nil)
      @id = id.to_i
      @time =  convert_to_sec(time)
      @cells = cells.to_i
      @code = code
    end

    def time=(time)
      @time = convert_to_sec(time)
    end

    def short_length?
      return time > 900 && time < 2100
    end

    protected

    def convert_to_sec(time)
      return time if time.is_a? Integer
      times = time.split(":")
      return (times[0].to_i * 3600) + (times[1].to_i * 60) + (times[2].to_i)
    end
  end
end

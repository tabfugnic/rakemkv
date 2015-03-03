#  Title
class RakeMKV::Title
  attr_reader :id, :code, :chapter_count, :size

  MINUTE = 60
  HOUR = 3600

  #  Initialize with a required id
  def initialize(id, options = {})
    # These claim to start at 1, but the CLI treats them as starting from 0
    @id = id
    @duration = options[:duration]
    @chapter_count = options[:chapter_count].to_i
    @size = options[:disk_size_bytes].to_i
  end

  # Find short lengthed title
  def short_length?
    time > 900 && time < 2100
  end

  def time
    time_from_integer || time_from_string
  end

  private

  attr_reader :duration

  def time_from_integer
    if duration.is_a? Integer
      duration
    end
  end

  def time_from_string
    times = duration.split(':')
    (times[0].to_i * HOUR) + (times[1].to_i * MINUTE) + (times[2].to_i)
  end
end

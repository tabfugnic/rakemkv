module RakeMKV
  ##
  #  Command Object
  #
  class Command
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def info
      @info ||= `#{app} info #{path}`
    end

    def mkv(title_id, destination)
      @mkv ||= `#{app} mkv #{path} #{title_id} #{destination}`
    end

    private

    def app
      'makemkvcon -r' # Always use robot mode
    end
  end
end

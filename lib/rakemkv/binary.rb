module RakeMKV
  class Binary
    WHICH="which".freeze

    def initialize(command_line_class: Terrapin::CommandLine)
      @command_line_class = command_line_class
    end

    def self.installed?
      new.installed?
    end

    def installed?
      !command_line_class.new(WHICH, makemkv_binary).run.empty?
    end

    private

    attr_reader :command_line_class

    def makemkv_binary
      RakeMKV.config.binary
    end
  end
end

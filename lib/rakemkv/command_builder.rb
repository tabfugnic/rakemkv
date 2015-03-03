class RakeMKV::CommandBuilder
  def initialize(command)
    @command = command
  end

  def build
    [command, minimum_length].join(' ').strip
  end

  private

  attr_reader :command

  def minimum_length
    if RakeMKV.config.minimum_title_length
      "--minlength=#{RakeMKV.config.minimum_title_length}"
    end
  end
end

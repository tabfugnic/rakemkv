#  Command Object
class RakeMKV::Command
  #  Initialize with path
  def initialize(path:, command_line_class: Terrapin::CommandLine)
    @path = path
    @command_line_class =  command_line_class
  end

  #  Call info command on disc
  def info(options = {})
    arguments = build_arguments(options)
    @info ||= execute("info #{path}", arguments)
  end

  #  Call mkv command on disc
  def mkv(title_id, destination, options = {})
    arguments = build_arguments(options)
    @mkv ||= execute("mkv #{path} #{title_id} #{destination}", arguments)
  end

  private

  attr_reader :command_line_class, :path

  def build_arguments(options)
    options.map do |key,value|
      "--#{key}=#{value}"
    end.join(" ")
  end

  def execute(command, arguments)
    full_command = [command, arguments].reject(&:empty?).join(" ")
    command_line_class.new(binary, full_command).run
  end

  def binary
    "#{RakeMKV.config.binary} -r"
  end
end

#  Command Object
class RakeMKV::Command
  #  Initialize with path
  def initialize(path)
    @path = path
  end

  #  Check if mkv is installed
  def self.installed?
    !Terrapin::CommandLine.new('which', RakeMKV.config.binary).run.empty?
  end

  #  Call info command on disc
  def info
    @info ||= execute("info #{@path}")
  end

  #  Call mkv command on disc
  def mkv(title_id, destination)
    @mkv ||= execute("mkv #{@path} #{title_id} #{destination}")
  end

  private

  def execute(command)
    Terrapin::CommandLine.new(
      "#{RakeMKV.config.binary} -r", full_command(command)
    ).run
  end

  def full_command(command)
    RakeMKV::CommandBuilder.new(command).build
  end
end

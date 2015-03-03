#  Command Object

class RakeMKV::Command
  APP = "#{RakeMKV.binary} -r"

  #  Initialize with path
  def initialize(path)
    @path = path
  end

  #  Check if mkv is installed
  def self.installed?
    output = Cocaine::CommandLine.new('which', APP).run
    !output.empty?
  end

  #  Call info command on disc
  def info
    @info ||= execute(APP, "info #{@path}")
  end

  #  Call mkv command on disc
  def mkv(title_id, destination)
    @mkv ||= execute(APP, "mkv #{@path} #{title_id} #{destination}")
  end

  private

  def execute(binary, command)
    Cocaine::CommandLine.new(binary, command).run
  end
end

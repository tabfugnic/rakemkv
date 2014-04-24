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
    @info ||= Cocaine::CommandLine.new(APP, 'info', @path).run
  end

  #  Call mkv command on disc
  def mkv(title_id, destination)
    @mkv ||= Cocaine::CommandLine.new(APP, 'mkv', @path, title_id, destination).run
  end
end

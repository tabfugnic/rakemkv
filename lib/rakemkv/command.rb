#  Command Object
class RakeMKV::Command
  APP = "#{RakeMKV.binary} -r"

  #  Initialize with path
  def initialize(path)
    @path = path
  end

  #  Check if mkv is installed
  def self.installed?
    !`which #{APP}`.empty?
  end

  #  Call info command on disc
  def info
    @info ||= `#{APP} info #{@path}`
  end

  #  Call mkv command on disc
  def mkv(title_id, destination)
    @mkv ||= `#{APP} mkv #{@path} #{title_id} #{destination}`
  end

  private
end

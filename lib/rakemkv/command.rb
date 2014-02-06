##
#  Command Object
#
class RakeMKV::Command
  attr_reader :path

  ##
  #  Initialize with path
  #
  def initialize(path)
    @path = path
  end

  ##
  #  Call info command on disc
  #
  def info
    @info ||= `#{app} info #{path}`
  end

  ##
  #  Call mkv command on disc
  #
  def mkv(title_id, destination)
    @mkv ||= `#{app} mkv #{path} #{title_id} #{destination}`
  end

  private

  def app
    'makemkvcon -r' # Always use robot mode
  end
end

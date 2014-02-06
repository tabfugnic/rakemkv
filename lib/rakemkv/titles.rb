##
# Titles
#
class RakeMKV::Titles < Array
  ##
  #  Initialize title with the assumption of parsed content
  #
  def initialize(titles)
    if titles.first.is_a? Hash
      titles.each_with_index do |title, title_id|
        self << RakeMKV::Title.new(title_id, title)
      end
    else
      super # default to treating it like an array
    end
  end

  ##
  #  Find title by id
  #
  def at_id(id)
    select { |title| title.id == id }.first
  end

  ##
  #  Get longest title
  #
  def longest
    max { |a, b| a.time <=> b.time }
  end
end

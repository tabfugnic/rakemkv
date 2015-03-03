# Titles
class RakeMKV::Titles
  include Enumerable

  def initialize(titles)
    @titles = titles
  end

  def each(&block)
    @titles.each(&block)
  end

  #  Find title by id
  def at_id(id)
    detect { |title| title.id == id }
  end

  #  Get longest title
  def longest
    max { |a, b| a.time <=> b.time }
  end
end

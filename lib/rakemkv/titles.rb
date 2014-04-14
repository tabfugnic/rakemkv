# Titles
class RakeMKV::Titles < Array

  #  Find title by id
  def at_id(id)
    select { |title| title.id == id }.first
  end

  #  Get longest title
  def longest
    max { |a, b| a.time <=> b.time }
  end
end

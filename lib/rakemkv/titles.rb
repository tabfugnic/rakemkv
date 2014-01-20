module RakeMKV
  ##
  # Titles
  #
  class Titles < Array
    def at_id(id)
      select { |title| title.id == id }.first
    end
  end
end

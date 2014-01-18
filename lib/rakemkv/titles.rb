module RakeMKV
  class Titles < Array

    def at_id(id)
      self.select { |title| title.id == id }.first
    end
  end
end

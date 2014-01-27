module RakeMKV
  ##
  # Titles
  #
  class Titles < Array
    def initialize(titles)
      if titles.first.is_a? Hash
        titles.each_with_index do |title, title_id|
          self << Title.new(title_id, title)
        end
      else
        super
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
end

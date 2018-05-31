require "spec_helper"

describe "transcoding disc" do
  it "copies disc to destination" do
    movie = File.new("./spec/fixtures/movie.iso")
    movie_path = File.expand_path(movie.path)

    Dir.mktmpdir do |directory|
      RakeMKV.config.minimum_title_length = 0
      RakeMKV.config.destination = directory

      RakeMKV::Disc.new(movie_path).transcode!

      expect(Dir.entries(directory)).to include("DVDVIDEO")
      expect(Dir.entries("#{directory}/DVDVIDEO")).to include("title00.mkv")
    end
  end
end

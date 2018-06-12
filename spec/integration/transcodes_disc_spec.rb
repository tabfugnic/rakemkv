require "spec_helper"

describe "transcoding disc" do
  it "copies the longest title of the disc to destination" do
    movie = File.new("./spec/fixtures/movie.iso")
    movie_path = File.expand_path(movie.path)

    Dir.mktmpdir do |directory|
      RakeMKV::Disc.new(
        destination: directory,
        location: movie_path,
        minlength: 3,
      ).transcode!

      expect(Dir.entries(directory)).to include("DVDVIDEO")
      expect(Dir.entries("#{directory}/DVDVIDEO")).to include("title00.mkv")
    end
  end

  it "copies all titles to the destination" do
    movie = File.new("./spec/fixtures/movie.iso")
    movie_path = File.expand_path(movie.path)

    Dir.mktmpdir do |directory|
      RakeMKV::Disc.new(
        destination: directory,
        location: movie_path,
        minlength: 2,
      ).transcode!(title_id: "all")

      expect(Dir.entries(directory)).to include("DVDVIDEO")
      expect(Dir.entries("#{directory}/DVDVIDEO")).
        to include("title00.mkv", "title01.mkv")
    end
  end
end

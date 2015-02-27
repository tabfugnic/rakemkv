require 'spec_helper'

describe 'transcoding disc' do
  it 'copies disc to destination' do
    movie = File.new('./spec/fixtures/movie.iso')
    movie_path = File.expand_path(movie.path)

    Dir.mktmpdir do |directory|
      RakeMKV::Disc.new(movie_path).transcode!(directory)

      expect(Dir.entries(directory)).to include('title00.mkv')
    end
  end
end

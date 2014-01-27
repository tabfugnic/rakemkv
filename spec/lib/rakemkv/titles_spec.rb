require 'spec_helper'

describe RakeMKV::Titles do

  describe '#at_id' do
    it 'finds titles by id but not place' do
      first_title = double(RakeMKV::Title, id: 0)
      last_title = double(RakeMKV::Title, id: 1)
      titles = RakeMKV::Titles.new([last_title, first_title])
      expect(titles.at_id(1)).to eq last_title
    end
  end

  describe '#new' do
    it 'initializes a bunch of titles using the title_hashes' do
      titles = [{ chapter_count: '24', duration: '1:10:22', disk_size_bytes: '4958869504' }]
      expect(RakeMKV::Title).to receive(:new)
      RakeMKV::Titles.new(titles)
    end

    it 'ignores arrays that are already title' do
      title = double(RakeMKV::Title, id: 1)
      expect(RakeMKV::Title).to_not receive(:new)
      RakeMKV::Titles.new([title])
    end
  end

  describe '#longest' do
    it 'finds the longest time' do
      short_title = double(RakeMKV::Title, time: 20)
      long_title = double(RakeMKV::Title, time: 50)
      titles = RakeMKV::Titles.new([short_title, long_title])
      expect(titles.longest).to eq long_title
    end
  end
end

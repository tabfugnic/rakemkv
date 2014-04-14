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

  describe '#longest' do
    it 'finds the longest time' do
      short_title = double(RakeMKV::Title, time: 20)
      long_title = double(RakeMKV::Title, time: 50)
      titles = RakeMKV::Titles.new([short_title, long_title])
      expect(titles.longest).to eq long_title
    end
  end
end

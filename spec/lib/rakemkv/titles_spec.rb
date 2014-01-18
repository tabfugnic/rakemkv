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
end

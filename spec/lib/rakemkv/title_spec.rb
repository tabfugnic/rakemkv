require 'spec_helper'

describe RakeMKV::Title do
  let(:title_info) do
    Hash[chapter_count: '24', duration: '1:10:22', disk_size_bytes: '4958869504']
  end
  describe '#initialize' do
    context 'title id' do
      it 'accepts title id' do
        expect(RakeMKV::Title.new(0, title_info).id).to eq 0
      end
    end
    context 'time in seconds' do
      it 'converts time to seconds' do
        expect(RakeMKV::Title.new(1, title_info).time).to eq 4222
      end
      it 'accepts integer seconds' do
        title_info[:duration] = 122
        expect(RakeMKV::Title.new(1, title_info).time).to eq 122
      end
    end
    context 'chapter count' do
      it 'accepts cells' do
        expect(RakeMKV::Title.new(1, title_info).chapter_count).to eq 24
      end
    end
    context 'size' do
      it 'accepts disk size in bytes' do
        expect(RakeMKV::Title.new(1, title_info).size).to eq 4_958_869_504
      end
    end
  end

  describe '#short_length?' do
    it 'is true for the goldie locks zone' do
      expect(RakeMKV::Title.new('1', duration: '0:16:00'))
        .to be_short_length
      expect(RakeMKV::Title.new('1', duration: '0:34:00'))
        .to be_short_length
    end
    it 'is false at any other time' do
      expect(RakeMKV::Title.new('1', duration: '0:15:00'))
        .to_not be_short_length
      expect(RakeMKV::Title.new('1', duration: '0:35:00'))
        .to_not be_short_length
    end
  end
end

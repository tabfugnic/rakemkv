require 'spec_helper'

describe RakeMKV::Disc do
  before do
    allow_any_instance_of(RakeMKV::Command)
      .to receive(:info) { RakeMKVMock.info }
  end

  describe '#path' do
    it 'accepts the device path' do
      RakeMKV::Disc.new('/dev/sd0').path.should eq 'dev:/dev/sd0'
    end
    it 'accepts the file iso path' do
      RakeMKV::Disc.new('path_to.iso').path.should eq 'iso:path_to.iso'
    end
    it 'accepts disc parameter' do
      RakeMKV::Disc.new('disc:0').path.should eq 'disc:0'
    end
    it 'accepts an integer for the path' do
      RakeMKV::Disc.new(0).path.should eq 'disc:0'
    end
    it 'raises an error when not a valid path' do
      expect { RakeMKV::Disc.new('bork').path }.to raise_error
    end
  end

  describe '#transcode!' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    let(:title) { double(RakeMKV::Title, id: 0) }
    before do
      File.stub(:directory?).and_return true
    end

    it 'errors when destination does not exist' do
      File.stub(:directory?).and_return false
      expect { disc.transcode!('/path/to/heart/') }.to raise_error
    end

    it 'converts only a specific title' do
      expect_any_instance_of(RakeMKV::Command).to receive(:mkv)
        .with(1, '/path/to/heart/')

      disc.transcode!('/path/to/heart/', title_id: 1)
    end
  end

  describe '#name' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    it 'grabs the name of the disc' do
      expect(disc.name).to eq 'DIME_NTSC'
    end
  end

  describe '#titles' do
    it 'builds a places to hold titles' do
      disc = RakeMKV::Disc.new('disc:0')

      expect(disc.titles).to be_a_kind_of(RakeMKV::Titles)
    end

    it 'returns a list of titles' do
      disc = RakeMKV::Disc.new('disc:0')
      RakeMKV::Title.stub(:new).and_return('new_title')

      expect(disc.titles).to include 'new_title'
    end
  end

  describe '.discs' do
    it 'checks all discs' do
      expect_any_instance_of(RakeMKV::Command).to receive(:info)
      RakeMKV::Disc.discs
    end
  end
end

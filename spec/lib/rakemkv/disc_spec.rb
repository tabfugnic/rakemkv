require 'spec_helper'

describe RakeMKV::Disc do
  before do
    allow_any_instance_of(RakeMKV::Command).to receive(:info) { RakeMKVMock.info }
  end

  describe '#new' do
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
      expect { RakeMKV::Disc.new('bork') }.to raise_error
    end
    it 'gets the info about the disk' do
      expect_any_instance_of(RakeMKV::Command).to receive(:info)
      RakeMKV::Disc.new('disc:0')
    end
    it 'parses the info into something more usable' do
      expect(RakeMKV::Parser).to receive(:new)
      RakeMKV::Disc.new('disc:0')
    end
  end

  describe '#titles' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    it 'finds all titles amongst returned content' do
      expect(disc.titles.first).to be_a RakeMKV::Title
    end
  end

  describe '#type' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    it 'finds the disc type' do
      expect(disc.type).to eq 'DVD disc'
    end
  end

  describe '#longest' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    let(:title) { double(RakeMKV::Title, time: 50) }
    it 'finds the longest time' do
      disc.stub(:titles) { [ double(RakeMKV::Title, time: 20), title] }
      expect(disc.longest).to eq title
    end
  end

  describe '#transcode!' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    before { File.stub(:directory?).and_return true }
    it 'errors when destination does not exist' do
      disc.stub(:titles).and_return [ RakeMKV::Title.new(0, 1222, 12) ]
      File.stub(:directory?).and_return false
      expect { disc.transcode!('/path/to/heart/') }.to raise_error
    end
    it 'accepts destination' do
      disc.stub(:titles).and_return [ RakeMKV::Title.new(0, 1222, 12) ]
      expect_any_instance_of(RakeMKV::Command).to receive(:mkv)
        .with(0, '/path/to/heart/').at_least(:once)
      disc.transcode!('/path/to/heart/')
    end
    it 'converts all relevant titles' do
      disc.stub(:titles).and_return [ RakeMKV::Title.new(0, 1222, 12), RakeMKV::Title.new(1, 1222, 12)]
      expect_any_instance_of(RakeMKV::Command).to receive(:mkv).with(0, '/path/to/heart/')
      expect_any_instance_of(RakeMKV::Command).to receive(:mkv).with(1, '/path/to/heart/')
      disc.transcode!('/path/to/heart/')
    end
    it 'converts titles based on time' do
      disc.stub(:titles).and_return [ RakeMKV::Title.new(0, 1000, 12), RakeMKV::Title.new(1, 2222, 12) ]
      expect_any_instance_of(RakeMKV::Command).to receive(:mkv)
        .with(1, '/path/to/heart/')
      disc.transcode!('/path/to/heart/')
    end
    it 'converts only a specific title' do
      disc.stub(:titles).and_return [ RakeMKV::Title.new(0, 2119, 12), RakeMKV::Title.new(1, 2222, 12)]
      expect_any_instance_of(RakeMKV::Command).to receive(:mkv)
        .with(1, '/path/to/heart/')
      disc.transcode!('/path/to/heart/', 1)
    end
  end

  describe '#name' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    it 'grabs the name of the disc' do
      expect(disc.name).to eq 'DIME_NTSC'
    end
  end

  describe '#short?' do
    subject(:disc) { RakeMKV::Disc.new('disc:0') }
    it 'returns true for short shows' do
      disc.stub(:titles).and_return([RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 1300, 2)])
      disc.short?.should be_true
    end
    it 'returns false when certain titles are too long' do
      disc.stub(:titles).and_return([RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 4300, 2)])
      disc.short?.should be_false
    end
  end

  describe '.discs' do
    it 'checks all discs' do
      expect(RakeMKV::Command).to receive(:new).with('disc:9999').and_call_original
      expect_any_instance_of(RakeMKV::Command).to receive(:info)
      RakeMKV::Disc.discs
    end
  end
end

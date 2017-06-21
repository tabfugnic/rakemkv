require 'spec_helper'

describe RakeMKV::Command do
  describe '.installed?' do
    it 'verifies makemkv is installed' do
      allow(Cocaine::CommandLine).to receive(:new)
        .with('which', 'makemkvcon')
        .and_return(double('command', run: '/something/great'))
      expect(RakeMKV::Command).to be_installed
    end
  end

  describe '#info' do
    it 'gets the info for the object' do
      command = RakeMKV::Command.new('disc:0')
      allow(Cocaine::CommandLine).to receive(:new)
        .with('makemkvcon -r', 'info disc:0')
        .and_return(double('cocaine', run: 'info'))
      expect(command.info).to eq 'info'
    end
  end

  describe '#mkv' do
    it 'takes title and destination' do
      command = RakeMKV::Command.new('disc:0')
      allow(Cocaine::CommandLine).to receive(:new)
        .with('makemkvcon -r', 'mkv disc:0 5 /path/to/heart')
        .and_return(double('cocaine', run: 'mkv'))
      expect(command.mkv(5,'/path/to/heart')).to eq 'mkv'
    end
  end
end

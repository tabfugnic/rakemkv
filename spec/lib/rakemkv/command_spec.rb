require 'spec_helper'

describe RakeMKV::Command do
  describe '#new' do
    it 'assigns path' do
      command = RakeMKV::Command.new('disc:0')
      expect(command.path).to eq 'disc:0'
    end
  end

  describe '#info' do
    it 'gets the info for the object' do
      command = RakeMKV::Command.new('disc:0')
      expect(command).to receive(:'`').with('makemkvcon -r info disc:0')
      command.info
    end
  end

  describe '#mkv' do
    subject(:command) { RakeMKV::Command.new('disc:0') }
    it 'takes title and destination' do
      expect(command).to receive(:'`').with('makemkvcon -r mkv disc:0 5 /path/to/heart')
      command.mkv(5,'/path/to/heart')
    end
  end
end

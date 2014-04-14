require 'spec_helper'

describe RakeMKV::Command do
  describe '.installed?' do
    it 'send message to verify makemkv is installed' do
      allow(RakeMKV::Command).to receive(:'`').and_return('')
      RakeMKV::Command.installed?
      expect(RakeMKV::Command).to have_received(:'`').with('which makemkvcon -r')
    end
    it 'verifies makemkv is installed' do
      RakeMKV::Command.stub(:'`').and_return('')
      expect(RakeMKV::Command).not_to be_installed
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

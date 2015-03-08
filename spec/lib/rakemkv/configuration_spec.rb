require 'spec_helper'

describe RakeMKV::Configuration do
  before do
    config.reset!
  end

  describe '#binary' do
    it 'returns default makemkvcon' do
      expect(config.binary).to eq 'makemkvcon'
    end

    it 'set a new binary' do
      config.binary = 'new_binary'
      expect(config.binary).to eq 'new_binary'
    end
  end

  describe '#destination' do
    it 'defaults the to current directory' do
      expect(config.destination).to eq Dir.pwd
    end

    it 'sets a new destination' do
      config.binary = 'new_destination'
      expect(config.binary).to eq 'new_destination'
    end
  end

  describe '#reset!' do
    it 'resets all the things' do
      config.minimum_title_length = 3
      config.binary = 'stuff'
      config.destination = '/path/somewhere'

      config.reset!

      expect(config.minimum_title_length).to be_nil
      expect(config.binary).to eq 'makemkvcon'
      expect(config.destination).to eq Dir.pwd
    end
  end

  def config
    RakeMKV::Configuration.instance
  end
end

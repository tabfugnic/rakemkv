require 'spec_helper'

describe RakeMKV::CommandBuilder do
  describe '#build' do
    it 'adds minimum length from configuration' do
      RakeMKV.configure do |config|
        config.minimum_title_length = 5
      end

      full_command = RakeMKV::CommandBuilder.new("command").build

      expect(full_command).to eq "command --minlength=5"
    end
  end
end

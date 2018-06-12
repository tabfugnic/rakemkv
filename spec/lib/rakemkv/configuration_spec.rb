require "spec_helper"

describe RakeMKV::Configuration do
  before do
    config.reset!
  end

  describe "#binary" do
    it "returns default makemkvcon" do
      expect(config.binary).to eq "makemkvcon"
    end

    it "set a new binary" do
      config.binary = "new_binary"
      expect(config.binary).to eq "new_binary"
    end
  end

  describe "#reset!" do
    it "resets all the things" do
      config.binary = "stuff"

      config.reset!

      expect(config.binary).to eq "makemkvcon"
    end
  end

  def config
    RakeMKV::Configuration.instance
  end
end

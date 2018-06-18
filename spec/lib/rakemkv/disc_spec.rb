require 'spec_helper'

describe RakeMKV::Disc do
  before do
    allow_any_instance_of(RakeMKV::Command)
      .to receive(:info) { RakeMKVMock.info }
  end

  describe "#path" do
    it "accepts the device path" do
      expect(RakeMKV::Disc.new(location: "/dev/sd0").path).to eq "dev:/dev/sd0"
    end

    it "accepts the file iso path" do
      expect(RakeMKV::Disc.new(location: "path_to.iso").path)
        .to eq "iso:path_to.iso"
    end

    it "accepts disc parameter" do
      expect(RakeMKV::Disc.new(location: "disc:0").path).to eq "disc:0"
    end

    it "accepts an integer for the path" do
      expect(RakeMKV::Disc.new(location: 0).path).to eq "disc:0"
    end

    it "raises an error when not a valid path" do
      expect { RakeMKV::Disc.new(location: "bork").path }.
        to raise_error(StandardError)
    end
  end

  describe "#transcode!" do
    it "converts only a specific title" do
      Dir.mktmpdir do |path|
        disc = RakeMKV::Disc.new(location: "disc:0", destination: path)
        allow(File).to receive(:directory?).and_return true
        expect_any_instance_of(RakeMKV::Command).
          to receive(:mkv).with(1, "#{path}/DIME_NTSC", { minlength: 120 })

        disc.transcode!(title_id: 1)
      end
    end
  end

  describe "#name" do
    it "grabs the name of the disc" do
      disc = RakeMKV::Disc.new(location: "disc:0")

      expect(disc.name).to eq "DIME_NTSC"
    end

    it "fixes the name with bad characters" do
      parsed = double("parsed", cinfo: { name: "thing/stuff" })
      parser_class = double("parser_class", new: parsed)

      disc = RakeMKV::Disc.new(location: "disc:0", parser_class: parser_class)

      expect(disc.name).to eq "thing_stuff"
    end
  end

  describe '#titles' do
    it 'builds a places to hold titles' do
      disc = RakeMKV::Disc.new(location: "disc:0")

      expect(disc.titles).to be_a_kind_of(RakeMKV::Titles)
    end

    it "returns a list of titles" do
      disc = RakeMKV::Disc.new(location: "disc:0")
      allow(RakeMKV::Title).to receive(:new).and_return("new_title")

      expect(disc.titles).to include "new_title"
    end
  end
end

require 'spec_helper'

describe RakeMKV::Disc do
  before do
    RakeMKV::Disc.any_instance.stub(:load_info) { RakeMKVMock.info }
  end
  context "instantiate path" do
    it "accepts the device path" do
      RakeMKV::Disc.new("/dev/sd0").path.should eq "dev:/dev/sd0"
    end
    it "accepts the file iso path" do
      RakeMKV::Disc.new("path_to.iso").path.should eq "iso:path_to.iso"
    end
    it "accepts disc parameter" do
      RakeMKV::Disc.new("disc:0").path.should eq "disc:0"
    end
    it "raises an error when not a valid path" do
      expect { RakeMKV::Disc.new("bork") }.to raise_error
    end
    it "gets the info about the disk" do
      RakeMKV::Disc.any_instance.stub(:load_info).and_call_original
      RakeMKV::Disc.any_instance.stub(:cleanup)
      expect_any_instance_of(RakeMKV::Disc)
        .to receive(:"`")
        .with("makemkvcon -r info disc:0")
      RakeMKV::Disc.new("disc:0")
    end
    it "parses the info into something more usable" do
      expect(RakeMKV::Disc.new("disc:0").info.first.first).to eq "MSG:1005"
    end
  end

  describe "#titles" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "finds all titles amongst returned content" do
      expect(subject.titles.first.id).to eq(0)
    end
    it "caches titles when called once" do
      pending "Need to figure out how to test caching"
      expect(subject).to receive(:info).once.and_return(RakeMKVMock.info)
      2.times { subject.titles }
    end
  end

  describe "#format" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "finds the disc format" do
      expect(subject.format).to eq "DVD"
    end
    it "caches the disc format when called" do
      pending "Need to figure out a better way to cache this"
      expect(subject).to receive(:info).once.and_return(RakeMKVMock.info)
      2.times { subject.format }
    end
  end

  describe "#longest" do
    subject { RakeMKV::Disc.new("disc:0") }
    let(:title) { double(RakeMKV::Title, time: 50) }
    it "finds the longest time" do
      subject.stub(:titles) { [ double(RakeMKV::Title, time: 20), title] }
      expect(subject.longest).to eq title
    end
  end

  describe "#transcode!" do
    subject { RakeMKV::Disc.new("disc:0") }
    before { File.stub(:directory?).and_return true }
    it "errors when destination doesn't exist" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12) ]
      File.stub(:directory?).and_return false
      expect { subject.transcode!("/path/to/heart/") }.to raise_error
    end
    it "accepts destination" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12) ]
      expect(subject).to receive(:"`").with("makemkvcon -r mkv disc:0 0 /path/to/heart/")
      subject.transcode!("/path/to/heart/")
    end
    it "converts all relevant titles" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12), RakeMKV::Title.new(2, 1222, 12)]
      expect(subject).to receive(:"`").with("makemkvcon -r mkv disc:0 0 /path/to/heart/")
      expect(subject).to receive(:"`").with("makemkvcon -r mkv disc:0 1 /path/to/heart/")
      subject.transcode!("/path/to/heart/")
      end
    it "converts titles based on time" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12), RakeMKV::Title.new(2, 222, 12) ]
      expect(subject).to receive(:"`").with("makemkvcon -r mkv disc:0 0 /path/to/heart/")
      subject.transcode!("/path/to/heart/")
    end
    it "converts only a specific title" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12), RakeMKV::Title.new(2, 1222, 12)]
      expect(subject).to receive(:"`").with("makemkvcon -r mkv disc:0 0 /path/to/heart/")
      subject.transcode!("/path/to/heart/", 0)
    end
  end

  describe "#name" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "grabs the name of the disc" do
      expect(subject.name).to eq "DIME_NTSC"
    end
    it "only calls this once" do
      pending "Need to figure out better way to cache this"
      expect(subject).to receive(:raw_info).once.and_return( RakeMKVMock.raw_info )
      2.times { subject.name }
    end
  end

  describe "#short?" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "returns true for short shows" do
      subject.stub(:titles).and_return([RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 1300, 2)])
      subject.short?.should be_true
    end
    it "returns false when certain titles are too long" do
      subject.stub(:titles).and_return([RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 1300, 2), RakeMKV::Title.new(3, 4300, 2)])
      subject.short?.should be_false
    end
  end
  describe ".drives" do
    it "checks all drives" do
      RakeMKV::Disc.should_receive("`").with("makemkvcon -r info disc:9999")
      RakeMKV::Disc.drives
    end
  end
end

require 'spec_helper'

describe RakeMKV::Disc do
  context "instantiate path" do
    it "accepts the device path" do
      RakeMKV::Disc.new("/dev/sd0").path.should eq "dev:sd0"
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
  end

   describe "#info" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "makes call to makemkv command line api" do
      subject.should_receive(:"`").with("makemkvcon -r info disc:0")
      subject.info
    end
    it "gets all info related to disc" do
      subject.stub(:"`").with("makemkvcon -r info disc:0"){ RakeMKVMock.info }
      subject.info.should match(/Using direct disc access mode/)
    end
    it "stores info for later" do
      subject.should_receive(:"`").once.and_return("doesn't matter")
      2.times { subject.info }
    end
  end

  describe "#titles" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "finds all titles amongst returned content" do
      subject.stub(:info) { RakeMKVMock.info }
      subject.titles.first.id.should eq(1)
    end
    it "caches titles when called once" do
      expect(subject).to receive(:info).once.and_return(RakeMKVMock.info)
      2.times { subject.titles }
    end
  end

  describe "#format" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "finds the disc format" do
      subject.stub(:info) { RakeMKVMock.info }
      expect(subject.format).to eq "DVD"
    end
    it "caches the disc format when called" do
      expect(subject).to receive(:info).once.and_return(RakeMKVMock.info)
      2.times { subject.format }
    end
  end

  describe "#destination" do
    subject { RakeMKV::Disc.new("disc:0") }
    it "finds the disc format" do
      subject.stub(:info) { RakeMKVMock.info }
      expect(subject.format).to eq "DVD"
    end
    it "caches the disc format when called" do
      expect(subject).to receive(:info).once.and_return(RakeMKVMock.info)
      2.times { subject.format }
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
      subject.should_receive(:"`").with("makemkvcon -r mkv disc:0 1 /path/to/heart/")
      subject.transcode!("/path/to/heart/")
    end
    it "converts all relevant titles" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12), RakeMKV::Title.new(2, 1222, 12)]
      subject.should_receive(:"`").with("makemkvcon -r mkv disc:0 1 /path/to/heart/")
      subject.should_receive(:"`").with("makemkvcon -r mkv disc:0 2 /path/to/heart/")
      subject.transcode!("/path/to/heart/")
      end
    it "converts titles based on time" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12), RakeMKV::Title.new(2, 222, 12) ]
      subject.should_receive(:"`").with("makemkvcon -r mkv disc:0 1 /path/to/heart/")
      subject.transcode!("/path/to/heart/")
    end
    it "converts only a specific title" do
      subject.stub(:titles).and_return [ RakeMKV::Title.new(1, 1222, 12), RakeMKV::Title.new(2, 1222, 12)]
      subject.should_receive(:"`").with("makemkvcon -r mkv disc:0 1 /path/to/heart/")
      subject.transcode!("/path/to/heart/", 1)
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

require 'spec_helper'

describe RakeMKV::Title do
  describe "#initialize" do
    context "title_id" do
      it "accepts title id" do
        RakeMKV::Title.new(1, "11", 12).num.should eq 1
      end
      it "accepts title id string" do
        RakeMKV::Title.new("1", "11", 12).num.should eq 1
      end
    end
    context "title_time" do
      it "converts time to seconds" do
        RakeMKV::Title.new(1, "1:10:22", 12 ).time.should eq 4222
      end
      it "accepts integer seconds" do
        RakeMKV::Title.new(1, 122, 12).time.should eq 122
      end
    end
    context "title_cells" do
      it "accepts cells" do
        RakeMKV::Title.new(1, "11", 12).cells.should eq 12
      end
      it "accepts cells string" do
        RakeMKV::Title.new("1", "11", "12").cells.should eq 12
      end
    end
  end

  describe "#time" do
    it "converts time to seconds" do
      title = RakeMKV::Title.new(1, "1:10:21", 12 )
      title.time = "1:10:22"
      title.time.should eq 4222
    end
  end

  describe "#short_length?" do
    it "is true for the goldie locks zone" do
      RakeMKV::Title.new("1", "0:16:00", 12).short_length?.should be_true
      RakeMKV::Title.new("1", "0:34:00", 12).short_length?.should be_true
    end
    it "is false at any other time" do
      RakeMKV::Title.new("1", "0:15:00", 12).short_length?.should be_false
      RakeMKV::Title.new("1", "0:35:00", 12).short_length?.should be_false
    end
  end
end

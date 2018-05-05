require "spec_helper"

describe RakeMKV::Binary do
  describe "#installed?" do
    it "verified makemkv is installed" do
      command_line = double("command_line", run: "thing")
      command_line_class = double("command_line_class", new: command_line)

      binary = described_class.new(command_line_class: command_line_class)

      expect(binary).to be_installed
    end
  end
end

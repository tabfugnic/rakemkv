require "spec_helper"

describe RakeMKV::Command do
  describe "#info" do
    it "gets the info for the object" do
      command_line = double("terrapin", run: "info")
      command_line_class = double(:command_line_class, new: command_line)

      command = described_class.new(
        path: "disc:0",
        command_line_class: command_line_class,
      )

      expect(command.info).to eq "info"
      expect(command_line_class).to have_received(:new)
        .with("makemkvcon -r", "info disc:0")
    end
  end

  describe "#mkv" do
    it "takes title and destination" do
      command_line = double("terrapin", run: "mkv")
      command_line_class = double(:command_line_class, new: command_line)

      command = described_class.new(
        path: "disc:0",
        command_line_class: command_line_class,
      )

      expect(
        command.mkv(5, "/path/to/heart"),
      ).to eq "mkv"
      expect(command_line_class).to have_received(:new)
        .with("makemkvcon -r", "mkv disc:0 5 /path/to/heart")
    end
  end
end

require 'spec_helper'

module RakeMKV
  describe Code do
    describe '#new' do
      it 'takes the index' do
        expect(RakeMKV::Code.new(5)).to be_a RakeMKV::Code
        expect(RakeMKV::Code.new(5).index).to eq 5
      end
    end
    describe '#to_sym' do
      it 'returns the code' do
        expect(RakeMKV::Code.new(5).to_sym).to eq :codec_id
      end
    end

    describe '.[]' do
      it 'gets the code' do
        expect(RakeMKV::Code[5]).to eq :codec_id
      end
    end
  end
end

require 'spec_helper'

describe RakeMKV::Parser do
  let(:parse) { RakeMKV::Parser.new(RakeMKVMock.info) }
  describe '#new' do
    it 'sets the raw info' do
      parse = RakeMKV::Parser.new('anything')
      expect(parse.raw).to eq 'anything'
    end
  end

  describe '#cinfo' do
    it 'parses information for cinfo' do
      expect(parse.cinfo[:name]).to eq 'DIME_NTSC'
    end
  end

  describe '#tinfo' do
    it 'parses title information' do
      expect(parse.tinfo[0][:chapter_count]).to eq '24'
    end
  end

  describe '#sinfo' do
    it 'parses title information' do
      expect(parse.sinfo[0][1][:audio_sample_rate]).to eq '48000'
    end
  end

  describe '#messages' do
    it 'parses messages information' do
      expect(parse.messages[0]).to eq 'MakeMKV v1.8.3 linux(x64-release) started'
    end
  end

  describe '#drives' do
    it 'parses drives information' do
      expect(parse.drives[0]).to eq({ accessible: true, drive_name: 'DVD+R-DL MATSHITA DVD-RAM UJ8C2 SB01', disc_name: 'DIME_NTSC' })
    end
  end

end

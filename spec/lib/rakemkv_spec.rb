require 'spec_helper'

describe RakeMKV, '.binary' do
  it 'uses makemkvcon as default' do
    expect(RakeMKV.binary).to eq 'makemkvcon'
  end
end

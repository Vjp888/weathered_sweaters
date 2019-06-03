require 'rails_helper'

describe DarkskyService do
  it 'returns weather information for a given location' do
    coords = {lat: 39.7392358, lng: -104.990251}
    darksky_service = DarkskyService.new
    result = darksky_service.get_weather(coords)

    expect(result).to be_a(Hash)
    expect(result[:hourly][:data].count).to eq(49)
    expect(result[:daily][:data].count).to eq(8)
  end
end

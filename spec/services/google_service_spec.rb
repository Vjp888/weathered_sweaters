require 'rails_helper'

describe GoogleService do
  it 'gets can return the long and lat of a given location' do
    address = 'Denver,co'
    mapbox_service = GoogleService.new
    result = mapbox_service.get_geo_coord(address)

    expect(result).to be_a(Hash)
    expect(result[:results].first[:geometry][:location]).to eq({lat: 39.7392358, lng: -104.990251})
  end
end

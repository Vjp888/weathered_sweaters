require 'rails_helper'

describe GoogleService do
  it 'gets can return the long and lat of a given location' do
    address = 'Denver,co'
    google_service = GoogleService.new
    result = google_service.get_geo_coord(address)

    expect(result).to be_a(Hash)
    expect(result[:results].first[:geometry][:location]).to eq({lat: 39.7392358, lng: -104.990251})
  end

  it 'returns an address for given lat and long of a location' do
    latlng = {lat: 27, long: -82}
    google_service = GoogleService.new
    result = google_service.get_address(latlng)

    expect(result).to be_a(Hash)
    expect(result[:results].first[:address_components][3][:short_name]).to eq('Charlotte County')
  end
end

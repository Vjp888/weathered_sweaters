require 'rails_helper'

describe 'antipode requests' do
  it 'returns the antipode of a given coordinate' do
    get '/api/v1/antipode?loc=hongkong'

    expect(response).to be_successful

    coords = JSON.parse(response.body)
    data = coords['data']

    expect(data['type']).to eq('antipode')
    expect(data['attributes']['location_name']).to eq('Yavi Department')
    expect(data['attributes']['forecast']['summary']).to eq('cloudy')
  end
end

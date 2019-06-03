require 'rails_helper'

describe 'antipode requests' do
  it 'returns the antipode of a given coordinate' do
    get '/api/v1/antipode?loc=hongkong'

    expect(response).to be_successful

    coords = JSON.parse(response.body)
    data = coords['data']

    expect(data['type']).to eq('antipode')
    expect(data['attributes']['lat']).to eq(-27.0)
    expect(data['attributes']['ong']).to eq(98.0)
  end
end

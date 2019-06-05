require 'rails_helper'

describe 'when I visit /backgrounds' do
  it 'returns a url of for a given background' do
    get '/api/v1/backgrounds?location=denver,co'

    data = JSON.parse(response.body)

    url = data['data']['attributes']

    expect(data).to have_key('data')
    expect(data['data']).to have_key('attributes')
    expect(data['data']['type']).to eq('background')
    expect(response.code).to eq('200')

    expect(url).to have_key('background')
  end
end

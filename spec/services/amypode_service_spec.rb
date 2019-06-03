require 'rails_helper'

describe AmypodeService do
  it 'returns the antipode of a specific coordinate' do
    lat = 27
    long = -82
    amypode_service = AmypodeService.new
    result = amypode_service.get_antipode(lat,long)

    expect(result).to be_a(Hash)
    expect(result[:data][:type]).to eq("antipode")
    expect(result[:data][:attributes][:lat]).to eq(-27.0)
    expect(result[:data][:attributes][:long]).to eq(98.0)
  end
end

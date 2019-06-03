require 'rails_helper'

describe AmypodeService do
  it 'returns the antipode of a specific coordinate' do
    lat = 27
    long = -82
    amypode_service = AmypodeService.new
    result = amypode_service.get_antipode(lat,long)

    expect(result).to be_a(Hash)
    expect(result[:type]).to eq("antipode")
    expect(result[:attributes][:lat]).to eq(-27)
    expect(result[:attributes][:long]).to eq(98)
  end
end

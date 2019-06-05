require 'rails_helper'

describe FlickrService do
  it 'returns json for a a flickr background image' do
    search_params = 'Denver,CO'
    flickr_service = FlickrService.new
    result = flickr_service.get_image(search_params)

    expect(result).to be_a(Hash)

    expect(result[:photos][:photo].first[:farm]).to_not be_nil
  end
end

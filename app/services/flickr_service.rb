class FlickrService

  def get_image(params)
    conn = Faraday.new("https://api.flickr.com/services/rest/?format=json&method=flickr.photos.search&tags=#{tag_prep(params)}&tag_mode=all&per_page=1&nojsoncallback=1&safe_search=1&api_key=#{ENV['FLICKR_KEY']}")
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def tag_prep(params)
    params + ',city,skyline'
  end
end

class DarkskyService

  def get_weather(coords)
    conn = Faraday.new('https://api.darksky.net/forecast/')
    response = conn.get(api_key + coord_prep(coords))
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_key
    ENV['DARKSKY_KEY']
  end

  def coord_prep(coords)
    "/#{coords[:lat]},#{coords[:lng]}"
  end
end

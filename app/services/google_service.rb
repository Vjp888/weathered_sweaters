class GoogleService
  def get_geo_coord(address)
    conn = Faraday.new('https://maps.googleapis.com/maps/api/geocode/')
    response = conn.get("json?" + address_prep(address.downcase) + api_key)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def api_key
    "&key=#{ENV['GOOGLE_GEOCODE_KEY']}"
  end

  def address_prep(address)
    "address=#{address.gsub(/,/, '+')}"
  end
end

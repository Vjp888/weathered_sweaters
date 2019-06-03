class AmypodeService
  def get_antipode(lat,long)
    conn = Faraday.new('http://amypode.herokuapp.com/api/v1/antipodes') do |f|
      f.adapter Faraday.default_adapter
      f.headers['api_key'] = api_key
    end
    response = conn.get(coord_prep(lat,long))
    JSON.parse(response.body, symbolize_names: true)
  end

  def coord_prep(lat,long)
    "?lat=#{lat}&long=#{long}"
  end

  def api_key
    'oscar_the_grouch'
  end
end

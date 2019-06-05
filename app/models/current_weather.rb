class CurrentWeather
  def initialize(json)
    @summary = json[:currently][:summary]
    @temperature = json[:currently][:temperature]
    @high_temp = json[:daily][:data].first[:temperatureHigh]
    @low_temp = json[:daily][:data].first[:temperatureLow]
    @humidity = "#{((json[:currently][:humidity]).to_f * 100).to_i}%"
    @uv_index = json[:currently][:uvIndex]
    @visibility = json[:currently][:visibility]
    @feels_like = json[:currently][:apparentTemperature]
  end
end

class WeatherFacade
  attr_reader :id, :location

  def initialize(params)
    @city = City.find_or_create_by(city_name: params.downcase)
    @location = @city.city_name
    @geocoord = coord_format
    @weather = weather_format
    @id = 1
  end

  def coord_format
    unless @city.latitude && @city.longitude
      @city.update(latitude: get_geo[:lat], longitude: get_geo[:lng])
    end
    {lat: @city.latitude, lng: @city.longitude}
  end

  def weather_format
    if @city.weather.nil? || @city.updated_at <= 1.hours.ago
      @city.update(weather: get_weather)
    end
    JSON.parse(@city.weather.to_json, symbolize_names: true)
  end

  def get_geo
    @_geo ||= GoogleService.new.get_geo_coord(@location)
    @_geo[:results].first[:geometry][:location]
  end

  def get_weather
    @_weather ||= DarkskyService.new.get_weather(@geocoord)
  end

  def current_weather
    @_current_weather ||= CurrentWeather.new(@weather)
  end

  def hourly_weather
    @_hourly_weather ||= @weather[:hourly][:data].map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def daily_weather
    @daily_weather ||= @weather[:daily][:data].map do |day|
      DailyWeather.new(day)
    end
  end

end

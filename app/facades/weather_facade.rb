class WeatherFacade
  attr_reader :id, :location

  def initialize(params)
    @location = params
    @id = 1
  end

  def get_geo
    @_geo ||= GoogleService.new.get_geo_coord(@location)
    @_geo[:results].first[:geometry][:location]
  end

  def get_weather
    @_weather ||= DarkskyService.new.get_weather(get_geo)
  end

  def current_weather
    @_current_weather ||= CurrentWeather.new(get_weather)
  end

  def hourly_weather
    @_hourly_weather ||= get_weather[:hourly][:data].map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def daily_weather
    @daily_weather ||= get_weather[:daily][:data].map do |day|
      DailyWeather.new(day)
    end
  end

end

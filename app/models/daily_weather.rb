class DailyWeather
  def initialize(json)
    @day = get_day(json[:time])
    @icon = json[:icon]
    @humidity = "#{((json[:humidity]).to_f * 100).to_i}%"
    @high_temp = json[:temperatureHigh]
    @low_temp = json[:temperatureLow]
  end

  def get_day(time)
    date = (DateTime.strptime(time.to_s, '%s')).to_date
    date.strftime('%A')
  end
end

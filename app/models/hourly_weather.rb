class HourlyWeather
  def initialize(json)
    @time = format_date(json[:time])
    @summary = json[:summary]
    @temperature = json[:temperature].to_f
    @icon = json[:icon]
  end

  def format_date(time)
    DateTime.strptime((time).to_s, '%s')
  end
end

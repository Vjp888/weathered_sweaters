class AntipodeFacade
attr_reader :id, :location_name, :type, :forecast, :search_location
  def initialize(location)
    @id = 1
    @type = 'antipode'
    @location = location
    @search_location = collect_location[:location]
    @location_name = collect_antipode(collect_location[:lat], collect_location[:lng])
    # @forcast = collect_forecast
    # binding.pry
  end

  def collect_forecast
    darksky = DarkskyService.new.get_weather()
  end

  def collect_location
      @_total_data ||= begin
        geo_code = GoogleService.new
        geo_coords = geo_code.get_geo_coord(@location)
        @_total_data = geo_coords[:results].first[:geometry][:location]
        @_total_data[:location] = geo_coords[:results].first[:formatted_address]
        @_total_data
      end
  end

  def collect_antipode(lat,long)
    @data ||= begin
      anti = AmypodeService.new
      data = anti.get_antipode(lat,long)
      coords = data[:data][:attributes]
      google = GoogleService.new.get_address(coords)
      @data = google[:results].first[:address_components].first[:long_name]
    end
  end
end

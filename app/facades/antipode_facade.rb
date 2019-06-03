class AntipodeFacade
attr_reader :id, :location_name, :type, :forecast
  def initialize(location)
    @id = 1
    @type = 'antipode'
    @location = location
    @search_location = collect_location[:location]
    # @forcast = collect_forecast
    @loation_name = collect_antipode(collect_location[:lat], collect_location[:lng])
    # geo = collect_location(params[:loc])
    # antipode = collect_antipode(geo[:lat],geo[:lng])
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
    anti = AmypodeService.new
    data = anti.get_antipode(lat,long)
    coords = data[:attributes]
    google = GoogleService.new.get_address({lat: lat, long: long})
    return google[:results].first[:address_components].first[:long_name]
  end
end

class FavoritesFacade
  attr_reader :id
  
  def initialize(user)
    @id = user.id
    @cities = user.cities
  end
  def favorite_cities
    x = @cities.map do |city|
      {'location': city.city_name, 'current_weather':
        WeatherFacade.new(city.city_name).current_weather}
    end
  end
end

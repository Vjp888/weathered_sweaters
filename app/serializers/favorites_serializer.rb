class FavoritesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :favorite_cities
end

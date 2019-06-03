class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :type, :location_name, :forecast, :search_location
end

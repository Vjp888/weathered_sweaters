class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    city = City.find_by(city_name: city_prep)
    if user && city
      user.favorites.create(city: city)
      render :json => { status: 200 }, status: 200
    else
      render :json => { status: 401 }, status: 401
    end
  end

  def index
    user = User.find_by(api_key: params[:api_key])
    if user
      favorites = FavoritesFacade.new(user)
      cities_json = FavoritesSerializer.new(favorites).as_json
      favorite_cities = cities_json['data']['attributes']['favorite_cities']
      render json: favorite_cities, status: 200
    else
      render json: {error: "Incorrect Api Key"}, status: 401
    end
  end

  def delete
    user = User.find_by(api_key: params[:api_key])
    city = City.find_by(city_name: city_prep)
    if user && user.cities.include?(city)
      favorite = user.favorites.find_by(city: city)
      user.favorites.delete(favorite)
      render json: {success: "Deleted #{city.city_name}"}, status: 200
    else
      render json: {error: "Unauthorized"}, status: 401
    end
  end

  private

  def city_prep
    (params[:location]).gsub(/[' ']/, '').downcase
  end
end

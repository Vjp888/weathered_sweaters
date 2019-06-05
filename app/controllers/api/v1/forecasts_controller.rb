class Api::V1::ForecastsController < ApplicationController
  def show
    weather = WeatherFacade.new(params[:location])
    render json: WeatherSerializer.new(weather)
  end
end

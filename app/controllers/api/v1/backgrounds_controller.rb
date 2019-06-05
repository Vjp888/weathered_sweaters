class Api::V1::BackgroundsController < ApplicationController
  def show
    background = BackgroundFacade.new(params[:location])
    render json: BackgroundSerializer.new(background)
  end
end

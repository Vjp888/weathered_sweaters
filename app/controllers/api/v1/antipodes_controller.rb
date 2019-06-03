class Api::V1::AntipodesController < ApplicationController
  def show
    antipode = AntipodeFacade.new(params[:loc])
    render json: AntipodeSerializer.new(antipode)
  end
end

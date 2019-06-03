class Api::V1::AntipodesController < ApplicationController
  def show
    geo_coords = collect_location(params[:loc])
    
    binding.pry
  end

  private

  def collect_location(params)
    geo_code = GoogleService.new
    geo_coords = geo_code.get_geo_coord(params)
    total_data = geo_coords[:results].first[:geometry][:location]
    total_data[:location] = geo_coords[:results].first[:formatted_address]
    total_data
  end
end

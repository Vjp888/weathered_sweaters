require 'rails_helper'

RSpec.describe Api::V1::ForecastsController, type: :controller do
  describe 'GET#show' do
    it 'returns HTTP success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end

require 'rails_helper'

describe 'When I visit /forecasts', type: :request do
  it 'returns json of forecast data' do

    get '/api/v1/forecast?location=denver,co'

    data = JSON.parse(response.body)

    current = data['data']['attributes']['current_weather']
    hourly = data['data']['attributes']['hourly_weather'].first
    daily = data['data']['attributes']['daily_weather'].first

    expect(data).to have_key('data')
    expect(data['data']).to have_key('attributes')
    expect(response.code).to eq('200')

    expect(current).to have_key('summary')
    expect(current).to have_key('temperature')
    expect(current).to have_key('high_temp')
    expect(current).to have_key('low_temp')
    expect(current).to have_key('humidity')
    expect(current).to have_key('uv_index')
    expect(current).to have_key('visibility')
    expect(current).to have_key('feels_like')

    expect(hourly).to have_key('time')
    expect(hourly).to have_key('summary')
    expect(hourly).to have_key('temperature')
    expect(hourly).to have_key('icon')

    expect(daily).to have_key('day')
    expect(daily).to have_key('icon')
    expect(daily).to have_key('humidity')
    expect(daily).to have_key('high_temp')
    expect(daily).to have_key('low_temp')
  end
end

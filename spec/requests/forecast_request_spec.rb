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

  it 'will save the forecast to the database if it is not present' do
    expect(City.all.count).to eq(0)

    get '/api/v1/forecast?location=denver,co'

    data = JSON.parse(response.body)

    expect(City.all.count).to eq(1)
  end

  it 'will only create on forecast if the forecast is searched multiple times' do
    expect(City.all.count).to eq(0)

    get '/api/v1/forecast?location=denver,co'

    expect(City.all.count).to eq(1)

    get '/api/v1/forecast?location=denver,co'

    expect(City.all.count).to eq(1)

    get '/api/v1/forecast?location=boulder,co'

    expect(City.all.count).to eq(2)
  end
end

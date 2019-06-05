require 'rails_helper'

describe 'when I visit /favorites' do
  before :each do
    @user = User.create(email: 'steve@steve.com', password: 'password', api_key: 'gotchu_fam')
    @city_1 = City.create(city_name: 'denver,co')
    @city_2 = City.create(city_name: 'boulder,co')
  end
  it 'allows me to add favorites to a user' do
    expect(@user.favorites.count).to eq(0)

    post '/api/v1/favorites', params:{
      "location": "Denver, CO",
      "api_key": "gotchu_fam"
    }

    data = JSON.parse(response.body)

    expect(data['status']).to eq(200)
    expect(@user.favorites.count).to eq(1)
  end

  it "lists all cities of a user's favorites" do
    Favorite.create(user: @user, city: @city_1)
    Favorite.create(user: @user, city: @city_2)

    get '/api/v1/favorites', params:{
      "api_key": "gotchu_fam"
    }
    data = JSON.parse(response.body)

    expect(response.code).to eq('200')
    expect(data.first['location']).to eq('denver,co')
    expect(data.first).to have_key('current_weather')
  end

  it 'will give an error if api key is wrong' do
    Favorite.create(user: @user, city: @city_1)
    Favorite.create(user: @user, city: @city_2)

    get '/api/v1/favorites', params:{
      "api_key": "12234"
    }
    data = JSON.parse(response.body)

    expect(response.code).to eq('401')
    expect(data).to have_key('error')
    expect(data['error']).to eq('Incorrect Api Key')
  end

  it 'allows a user to delete a favorite' do
    Favorite.create(user: @user, city: @city_1)
    Favorite.create(user: @user, city: @city_2)

    delete '/api/v1/favorites', params:{
      "location": "Denver, CO",
      "api_key": "gotchu_fam"
    }

    data = JSON.parse(response.body)

    expect(response.code).to eq('200')
    expect(data['success']).to eq("Deleted #{@city_1.city_name}")
  end

  it 'Errors when a deleting with invalid api' do
    Favorite.create(user: @user, city: @city_1)
    Favorite.create(user: @user, city: @city_2)

    delete '/api/v1/favorites', params:{
      "location": "Denver, CO",
      "api_key": "12344"
    }

    data = JSON.parse(response.body)

    expect(response.code).to eq('401')
    expect(data['error']).to eq("Unauthorized")
  end
end

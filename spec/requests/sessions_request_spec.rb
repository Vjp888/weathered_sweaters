require 'rails_helper'

describe 'when I visit /session' do
  it 'will return an api key for that user' do
    user = User.create(email: 'steve@steve.com', password: 'password', api_key: 'epic fam')

    post '/api/v1/sessions', params: {
      "email": "steve@steve.com",
      "password": "password"
    }

    data = JSON.parse(response.body)

    expect(response.code).to eq('200')
    expect(data['api_key']).to_not be_nil
    expect(user.api_key).to eq(data['api_key'])
  end

  it 'will error if credentials are incorrect' do
    post '/api/v1/sessions', params: {
      "email": "steve@steve.com",
      "password": "password"
    }

    data = JSON.parse(response.body)

    expect(response.code).to eq('401')
    expect(data['error']).to eq("Invalid Email or Password, please try again")
  end
end

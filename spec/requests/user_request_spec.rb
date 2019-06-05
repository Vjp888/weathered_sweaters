require 'rails_helper'

describe 'When I visit /users' do
  it 'creates a user' do
    post '/api/v1/users', params: {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    data = JSON.parse(response.body)

    user = User.last

    expect(response.code).to eq('201')
    expect(data['api_key']).to_not be_nil
    expect(user.api_key).to eq(data['api_key'])
  end
end

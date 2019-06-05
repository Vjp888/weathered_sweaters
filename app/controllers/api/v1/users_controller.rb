class Api::V1::UsersController < ApplicationController
  # protect_from_forgery with: :null_session

  def create
    user = User.new(user_params)
    user.api_key = SecureRandom.hex(20)
    if user.save
      render :json => { :api_key => user.api_key }, status: 201
    else
      render :json => { :errors => user.errors.full_messages }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

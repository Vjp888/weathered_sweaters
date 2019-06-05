class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render :json => { :api_key => user.api_key }, status: 200
    else
      render :json => { :error => "Invalid Email or Password, please try again" }, status: 401
    end
  end
end

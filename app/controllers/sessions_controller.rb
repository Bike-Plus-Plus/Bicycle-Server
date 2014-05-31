class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      user.token = SecureRandom.hex
      user.save!
      render json: { access_token: user.token, token_type: 'bearer' }
    else
      render json: {error: "Email or password is invalid"}, status: :unauthorized
    end
  end
end
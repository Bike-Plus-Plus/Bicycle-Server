class UsersController < ApplicationController
  before_action :authenticate, :only => [:show, :update, :destroy]

  respond_to :json

  def show
    respond_with current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update(user_params)
      render nothing: true, status: 204
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

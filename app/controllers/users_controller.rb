class UsersController < ApplicationController
  #before_action :authenticate_user!, only: [:show]
  # before_filter :authenticate_user!, only: [:show]
  
  def index
    @users = User.all
    render json: @users.to_json(only: [:id, :username])
  end
  
  # user profile
  def show
    @user = User.find(params[:id])
  end
end

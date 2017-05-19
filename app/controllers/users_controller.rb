class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users.to_json(only: [:id, :username])
  end

  def show
    @user = User.find(params[:id])
  end
end
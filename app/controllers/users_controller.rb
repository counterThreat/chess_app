class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users.to_json(only: [:id, :username])
  end
end

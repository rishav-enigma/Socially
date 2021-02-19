class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.where.not(id: current_user.id)
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(current_user) if user_signed_in?
  end
end

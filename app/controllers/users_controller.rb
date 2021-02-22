class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :posts]
  def index
    if user_signed_in?
      @users = User.where.not(id: current_user.id)
    else
      @users = User.all
    end
  end

  def show
    help
  end

  def posts
    help
  end

  private
  def help
    @comment = Comment.new
    @user = User.find(params[:user_id])
    if user_signed_in? && current_user.id == @user.id
      @posts = @user.posts
    elsif user_signed_in? && @user.friends.include?(current_user)
      @posts = @user.posts.where(visibility: "everyone") + @user.posts.where(visibility: "friends")
    else
      @posts = @user.posts.where(visibility: "everyone")
    end
  end
end

class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.where.not(id: current_user.id).paginate(page: params[:page], per_page: 5)
    else
      @users = User.all.paginate(page: params[:page], per_page: 5)
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
      @posts = @user.posts.where(visibility: ["everyone", "friends"]).paginate(page: params[:page], per_page: 5)
    else
      @posts = @user.posts.where(visibility: "everyone").paginate(page: params[:page], per_page: 5)
    end
  end
end

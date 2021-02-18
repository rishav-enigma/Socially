class LikesController < ApplicationController
  before_action :find_post
  def create
    @post.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post.likes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.js
    end
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

end

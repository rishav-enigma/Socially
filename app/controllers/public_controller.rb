class PublicController < ApplicationController
  def home
    @minimum_password_length = User.password_length.min
    @post = Post.new if user_signed_in?
    if user_signed_in? && current_user.feed
      @feed_posts = current_user.feed
      @comment = Comment.new if user_signed_in?
      @limit = 1
    else
      @feed_posts = Post.all.where(visibility: Post.visibilities["everyone"]).order(created_at: :desc)
      @comment = Comment.new if user_signed_in?
      @limit = 1
    end
  end
end

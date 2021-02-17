class PublicController < ApplicationController
  def home
    @minimum_password_length = User.password_length.min
    @post = Post.new if user_signed_in?
    if user_signed_in? && current_user.feed
      @feed_posts = current_user.feed
    else
      @feed_posts = Post.all.where(visibility: Post.visibilities["everyone"]).order(created_at: :desc)
    end
  end
end
